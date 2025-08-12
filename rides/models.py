from django.db import models
from django.contrib.auth.models import AbstractUser
from django.utils import timezone
from datetime import timedelta


class User(AbstractUser):
    """
    Extended User model matching the specified table structure.
    Uses Django's built-in AbstractUser and adds custom fields.
    """
    # Custom fields as per specification
    id_user = models.AutoField(primary_key=True)  # Custom primary key name
    role = models.CharField(max_length=50, default='rider')  # User role (admin, rider, driver)
    first_name = models.CharField(max_length=150)  # Override to make required
    last_name = models.CharField(max_length=150)   # Override to make required
    email = models.EmailField(unique=True)         # Ensure unique emails
    phone_number = models.CharField(max_length=20, blank=True, null=True)
    
    class Meta:
        db_table = 'user'  # Match specified table name
        indexes = [
            models.Index(fields=['role']),     # Index for role-based queries
            models.Index(fields=['email']),    # Index for email searches
        ]
    
    def __str__(self):
        return f"{self.first_name} {self.last_name} ({self.role})"


class Ride(models.Model):
    """
    Ride model matching the exact specification.
    Handles ride information with pickup/dropoff coordinates.
    """
    # Status choices as mentioned in specification
    STATUS_CHOICES = [
        ('en-route', 'En Route'),
        ('pickup', 'Pickup'),
        ('dropoff', 'Dropoff'),
        ('completed', 'Completed'),
        ('cancelled', 'Cancelled'),
    ]
    
    # Fields matching exact specification
    id_ride = models.AutoField(primary_key=True)
    status = models.CharField(max_length=50, choices=STATUS_CHOICES, default='en-route')
    
    # Foreign keys to User model with specific related names
    id_rider = models.ForeignKey(
        User, 
        on_delete=models.CASCADE, 
        related_name='rides_as_rider',
        db_column='id_rider'  # Ensure column name matches spec
    )
    id_driver = models.ForeignKey(
        User, 
        on_delete=models.CASCADE, 
        related_name='rides_as_driver',
        null=True, 
        blank=True,
        db_column='id_driver'  # Ensure column name matches spec
    )
    
    # Location coordinates as per specification
    pickup_latitude = models.FloatField()
    pickup_longitude = models.FloatField()
    dropoff_latitude = models.FloatField()
    dropoff_longitude = models.FloatField()
    
    # Pickup time as specified
    pickup_time = models.DateTimeField()
    
    # Additional useful fields for tracking
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        db_table = 'ride'  # Match specified table name
        indexes = [
            models.Index(fields=['status']),                    # For status filtering
            models.Index(fields=['pickup_time']),               # For time-based sorting
            models.Index(fields=['id_rider', 'status']),        # Composite index for rider queries
            models.Index(fields=['id_driver', 'status']),       # Composite index for driver queries
            models.Index(fields=['pickup_latitude', 'pickup_longitude']),  # For geo queries
        ]
    
    def __str__(self):
        return f"Ride {self.id_ride} - {self.status}"


class RideEvent(models.Model):
    """
    RideEvent model matching the exact specification.
    Stores events that occur during a ride lifecycle.
    """
    # Fields matching exact specification
    id_ride_event = models.AutoField(primary_key=True)
    id_ride = models.ForeignKey(
        Ride, 
        on_delete=models.CASCADE, 
        related_name='events',
        db_column='id_ride'  # Ensure column name matches spec
    )
    description = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        db_table = 'ride_event'  # Match specified table name
        indexes = [
            models.Index(fields=['id_ride', 'created_at']),     # For ride-specific event queries
            models.Index(fields=['created_at']),                # For time-based queries
            models.Index(fields=['description']),               # For event type filtering
            # Partial index for today's events (PostgreSQL specific optimization)
            models.Index(
                fields=['id_ride', 'created_at'],
                name='ride_event_today_idx',
                condition=models.Q(created_at__gte=timezone.now() - timedelta(days=1))
            ),
        ]
        ordering = ['-created_at']  # Default ordering by most recent
    
    def __str__(self):
        return f"Event {self.id_ride_event} - {self.description}"

