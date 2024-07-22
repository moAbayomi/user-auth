from django.urls import path
from .views import BlogListView, BlogDetailView, BlogCreateView, BlogEditView, BlogDeleteView


urlpatterns = [
    path("", BlogListView.as_view(), name="home"), 
    path("details/<int:pk>", BlogDetailView.as_view(), name="detail"),
    path("new", BlogCreateView.as_view(), name="new_post"),
    path("edit/<int:pk>", BlogEditView.as_view(), name="edit_post"),
    path("delete/<int:pk>", BlogDeleteView.as_view(), name="delete_post")
]