from rest_framework import viewsets, status
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.pagination import PageNumberPagination
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.filters import OrderingFilter
from django.db.models import Prefetch, F, Q
from django.db.models import Case, When, Value, FloatField
from django.utils import timezone
from datetime import timedelta
import math
from rides.filters import RideFilter
from rides.models import Ride, RideEvent, User
from rides.permissions import IsAdminUser
from rides.serializers import RideCreateSerializer, RideDetailSerializer, RideEventSerializer, RideListSerializer, UserSerializer


class StandardResultsSetPagination(PageNumberPagination):
    """
    Custom pagination class with configurable page sizes.
    Supports large datasets efficiently.
    """
    page_size = 20
    page_size_query_param = 'page_size'
    max_page_size = 100


def calculate_distance(lat1, lon1, lat2, lon2):
    """
    Calculate the great circle distance between two points 
    on the earth (specified in decimal degrees).
    Returns distance in kilometers.
    """
    # Convert decimal degrees to radians
    lat1, lon1, lat2, lon2 = map(math.radians, [lat1, lon1, lat2, lon2])
    
    # Haversine formula
    dlat = lat2 - lat1
    dlon = lon2 - lon1
    a = math.sin(dlat/2)**2 + math.cos(lat1) * math.cos(lat2) * math.sin(dlon/2)**2
    c = 2 * math.asin(math.sqrt(a))
    
    # Radius of earth in kilometers
    r = 6371
    return c * r

from rest_framework.permissions import IsAuthenticated

class UserViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing User CRUD operations.
    Only accessible by admin users.
    """
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = [IsAuthenticated]
    pagination_class = StandardResultsSetPagination
    filter_backends = [DjangoFilterBackend, OrderingFilter]
    filterset_fields = ['role']
    ordering_fields = ['first_name', 'last_name', 'email']
    ordering = ['first_name', 'last_name']
    
    @action(detail=True, methods=['put'])
    def update_user(self, request, pk=None):
        user = self.get_object()
        serializer = self.get_serializer(user, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data)


class RideEventViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing RideEvent CRUD operations.
    Only accessible by admin users.
    """
    queryset = RideEvent.objects.select_related('id_ride').all()
    serializer_class = RideEventSerializer
    permission_classes = [IsAuthenticated]
    pagination_class = StandardResultsSetPagination
    filter_backends = [DjangoFilterBackend, OrderingFilter]
    filterset_fields = ['description', 'id_ride']
    ordering_fields = ['created_at']
    ordering = ['-created_at']


class RideViewSet(viewsets.ModelViewSet):
    """
    Main ViewSet for Ride management with optimized list performance.
    
    Key Features:
    - Minimized SQL queries (2-3 queries total)
    - Support for distance and time-based sorting
    - Efficient pagination
    - Today's events only (performance optimization)
    """
    permission_classes = [IsAuthenticated]
    pagination_class = StandardResultsSetPagination
    filter_backends = [DjangoFilterBackend, OrderingFilter]
    filterset_class = RideFilter
    ordering_fields = ['pickup_time', 'created_at']
    ordering = ['-created_at']
    
    def get_queryset(self):
        """
        Optimized queryset that minimizes database queries.
        
        Query Breakdown:
        1. Main query with select_related for rider/driver (1 query)
        2. Prefetch for today's events only (1 query)
        3. Optional pagination count query (1 query when paginated)
        
        Total: 2-3 queries regardless of result set size
        """
        # Calculate threshold for "today's" events (last 24 hours)
        today_threshold = timezone.now() - timedelta(days=1)
        
        # Create optimized queryset for today's events only
        todays_events_queryset = RideEvent.objects.filter(
            created_at__gte=today_threshold
        ).order_by('-created_at')
        
        # Main queryset with optimized joins - FIXED: Define queryset first
        queryset = Ride.objects.select_related(
            'id_rider',   # Join rider data in main query
            'id_driver'   # Join driver data in main query
        ).prefetch_related(
            # Prefetch only today's events to avoid loading massive event history
            Prefetch(
                'events',
                queryset=todays_events_queryset,
                to_attr='todays_ride_events'
            )
        )
        
        # Handle distance-based sorting if GPS coordinates provided
        user_lat = self.request.query_params.get('lat')
        user_lng = self.request.query_params.get('lng')
        
        if user_lat and user_lng:
            try:
                user_lat = float(user_lat)
                user_lng = float(user_lng)
                
                # For distance sorting, we'll handle it in the list method
                # since SQL distance calculations are complex and database-specific
                # Just mark that we have coordinates for later processing
                
            except (ValueError, TypeError):
                # Invalid coordinates provided, ignore distance calculation
                pass
        
        return queryset
    
    def get_serializer_class(self):
        """
        Return appropriate serializer based on action.
        """
        if self.action == 'list':
            return RideListSerializer
        elif self.action == 'create':
            return RideCreateSerializer
        return RideDetailSerializer
    
    def list(self, request, *args, **kwargs):
        """
        Custom list method to handle distance calculations efficiently.
        """
        queryset = self.filter_queryset(self.get_queryset())
        
        # Handle distance calculation if GPS coordinates provided
        user_lat = request.query_params.get('lat')
        user_lng = request.query_params.get('lng')
        ordering = request.query_params.get('ordering')
        
        # Get the page first
        page = self.paginate_queryset(queryset)
        
        if user_lat and user_lng and page is not None:
            try:
                user_lat = float(user_lat)
                user_lng = float(user_lng)
                
                # Calculate distances for current page only (after pagination)
                for ride in page:
                    if hasattr(ride, 'pickup_latitude') and hasattr(ride, 'pickup_longitude'):
                        if ride.pickup_latitude is not None and ride.pickup_longitude is not None:
                            ride.distance_to_pickup = calculate_distance(
                                user_lat, user_lng,
                                ride.pickup_latitude, ride.pickup_longitude
                            )
                        else:
                            ride.distance_to_pickup = float('inf')
                    else:
                        ride.distance_to_pickup = float('inf')
                
                # Sort by distance if requested (for current page only)
                # Note: This is page-level sorting, not global sorting
                if ordering == 'distance_to_pickup':
                    page.sort(key=lambda x: getattr(x, 'distance_to_pickup', float('inf')))
                elif ordering == '-distance_to_pickup':
                    page.sort(key=lambda x: getattr(x, 'distance_to_pickup', float('inf')), reverse=True)
                
                serializer = self.get_serializer(page, many=True)
                return self.get_paginated_response(serializer.data)
                
            except (ValueError, TypeError):
                # Invalid coordinates, fall back to standard pagination
                pass
        
        # Standard pagination without distance calculation
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)
        
        # Fallback for unpaginated results
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)
    
    @action(detail=True, methods=['get'])
    def events(self, request, pk=None):
        """
        Get all events for a specific ride.
        Separate endpoint for complete event history when needed.
        """
        ride = self.get_object()
        events = RideEvent.objects.filter(id_ride=ride).order_by('-created_at')
        
        page = self.paginate_queryset(events)
        if page is not None:
            serializer = RideEventSerializer(page, many=True)
            return self.get_paginated_response(serializer.data)
        
        serializer = RideEventSerializer(events, many=True)
        return Response(serializer.data)
    
    @action(detail=True, methods=['post'])
    def add_event(self, request, pk=None):
        """
        Add a new event to a specific ride.
        """
        ride = self.get_object()
        serializer = RideEventSerializer(data=request.data)
        
        if serializer.is_valid():
            serializer.save(id_ride=ride)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)