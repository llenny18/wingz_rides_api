
import django_filters
from django.db.models import Q

from rides.models import Ride


class RideFilter(django_filters.FilterSet):
    """
    Custom filter class for the Ride model.
    Supports filtering by status and rider email as specified.
    """
    # Filter by ride status
    status = django_filters.ChoiceFilter(
        choices=Ride.STATUS_CHOICES,
        help_text="Filter by ride status"
    )
    
    # Filter by rider email (case-insensitive contains search)
    rider_email = django_filters.CharFilter(
        field_name='id_rider__email', 
        lookup_expr='icontains',
        help_text="Filter by rider email (partial match)"
    )
    
    # Additional useful filters
    pickup_time_after = django_filters.DateTimeFilter(
        field_name='pickup_time', 
        lookup_expr='gte',
        help_text="Filter rides with pickup time after specified datetime"
    )
    pickup_time_before = django_filters.DateTimeFilter(
        field_name='pickup_time', 
        lookup_expr='lte',
        help_text="Filter rides with pickup time before specified datetime"
    )
    
    class Meta:
        model = Ride
        fields = ['status', 'rider_email', 'pickup_time_after', 'pickup_time_before']
