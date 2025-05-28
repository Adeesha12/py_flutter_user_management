from django.test import TestCase
from django.urls import reverse
from .models import User  # Adjust import based on your actual model

class UserModelTest(TestCase):
    def setUp(self):
        self.user = User.objects.create(username='testuser', email='test@example.com')

    def test_user_creation(self):
        self.assertEqual(self.user.username, 'testuser')
        self.assertEqual(self.user.email, 'test@example.com')
        self.assertFalse(self.user.is_staff)



class UserViewTest(TestCase):
    def test_user_list_view(self):
        response = self.client.get(reverse('users:list'))  # Adjust URL name accordingly
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'testuser')
