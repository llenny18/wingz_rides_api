
from rest_framework.permissions import BasePermission


class IsAdminUser(BasePermission):
    """
    Custom permission class to ensure only admin users can access the API.
    Checks both authentication and admin role.
    """
    
    def has_permission(self, request, view):
        """
        Check if user is authenticated and has admin role.
        """
        return (
            request.user and 
            request.user.is_authenticated and 
            request.user.role == 'admin'
        )
