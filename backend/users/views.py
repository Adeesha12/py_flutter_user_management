from rest_framework import viewsets
from .models import User
from .serializers import UserSerializer
from rest_framework.parsers import MultiPartParser, FormParser

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all().order_by('-id')
    serializer_class = UserSerializer
    parser_classes = [MultiPartParser, FormParser]
