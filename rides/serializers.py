
from rest_framework import serializers
from django.contrib.gis.geos import Point
from django.utils import timezone
from datetime import timedelta
import math

from rides.models import Ride, RideEvent, User


class UserSerializer(serializers.ModelSerializer):
    """
    User serializer for API responses.
    Includes all necessary user information.
    """
    class Meta:
        model = User
        fields = [
            'id_user', 'username', 'email', 'first_name', 
            'last_name', 'role', 'phone_number'
        ]
        read_only_fields = ['id_user']


class RideEventSerializer(serializers.ModelSerializer):
    """
    Standard RideEvent serializer for detailed event information.
    """
    class Meta:
        model = RideEvent
        fields = ['id_ride_event', 'description', 'created_at']
        read_only_fields = ['id_ride_event', 'created_at']


class TodaysRideEventSerializer(serializers.ModelSerializer):
    """
    Optimized serializer specifically for today's events.
    Used in the ride list to minimize data transfer.
    """
    class Meta:
        model = RideEvent
        fields = ['id_ride_event', 'description', 'created_at']


class RideListSerializer(serializers.ModelSerializer):
    """
    Optimized serializer for the ride list API.
    Includes related data and calculated fields for performance.
    """
    # Related user data
    rider = UserSerializer(source='id_rider', read_only=True)
    driver = UserSerializer(source='id_driver', read_only=True)
    
    # Today's events only (performance optimization)
    todays_ride_events = TodaysRideEventSerializer(many=True, read_only=True)
    
    # Distance calculation result (added when GPS coordinates provided)
    distance_to_pickup = serializers.FloatField(read_only=True, required=False)
    
    class Meta:
        model = Ride
        fields = [
            'id_ride', 'status', 'pickup_time', 'created_at',
            'pickup_latitude', 'pickup_longitude',
            'dropoff_latitude', 'dropoff_longitude',
            'rider', 'driver', 'todays_ride_events', 'distance_to_pickup'
        ]


class RideDetailSerializer(serializers.ModelSerializer):
    """
    Detailed serializer for single ride operations.
    Includes all related data for comprehensive ride information.
    """
    rider = UserSerializer(source='id_rider', read_only=True)
    driver = UserSerializer(source='id_driver', read_only=True)
    events = RideEventSerializer(many=True, read_only=True)
    
    class Meta:
        model = Ride
        fields = [
            'id_ride', 'status', 'pickup_time', 'created_at', 'updated_at',
            'pickup_latitude', 'pickup_longitude',
            'dropoff_latitude', 'dropoff_longitude',
            'rider', 'driver', 'events'
        ]


class RideCreateSerializer(serializers.ModelSerializer):
    """
    Serializer for creating new rides.
    Includes validation for coordinates and required fields.
    """
    class Meta:
        model = Ride
        fields = [
            'status', 'id_rider', 'id_driver', 'pickup_time',
            'pickup_latitude', 'pickup_longitude',
            'dropoff_latitude', 'dropoff_longitude'
        ]
    
    def validate(self, data):
        """
        Validate coordinate ranges and other business rules.
        """
        # Validate latitude range
        for lat_field in ['pickup_latitude', 'dropoff_latitude']:
            if lat_field in data:
                if not -90 <= data[lat_field] <= 90:
                    raise serializers.ValidationError(f"{lat_field} must be between -90 and 90")
        
        # Validate longitude range
        for lng_field in ['pickup_longitude', 'dropoff_longitude']:
            if lng_field in data:
                if not -180 <= data[lng_field] <= 180:
                    raise serializers.ValidationError(f"{lng_field} must be between -180 and 180")
        
        return data