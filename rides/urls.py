
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from rest_framework.authtoken.views import obtain_auth_token

from rides.views import RideEventViewSet, RideViewSet, UserViewSet

router = DefaultRouter()
router.register(r'users', UserViewSet)
router.register(r'rides', RideViewSet, basename='ride')
router.register(r'ride-events', RideEventViewSet)

urlpatterns = [
    path('api/v1/', include(router.urls)),
    path('api/v1/auth/token/', obtain_auth_token, name='api_token_auth'),
    
]
