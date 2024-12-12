from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import User, OTP , PasswordResetToken

class CustomUserAdmin(UserAdmin):
    model = User

    # Define the fields to display in the admin list view
    list_display = ('email', 'username', 'full_name', 'is_verified', 'is_superuser')
    
    # Filters for the list view
    list_filter = ('is_staff', 'is_active', 'is_verified')
    
    # Fields to search by
    search_fields = ('email', 'username')
    
    # Read-only fields in the form view
    readonly_fields = ('date_joined', 'last_login')

    fieldsets = (
        (None, {'fields': ('email', 'password')}),
        ('Personal info', {'fields': ('full_name', 'username', 'is_verified')}),
        ('Permissions', {'fields': ('is_active', 'is_staff', 'is_superuser', 'groups', 'user_permissions')}),
        ('Important dates', {'fields': ('last_login', 'date_joined')}),
    )

    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('email', 'username', 'password1', 'password2'),
        }),
    )
    
    filter_horizontal = ('groups', 'user_permissions')

# Register the custom user model and admin
admin.site.register(User)
admin.site.register(OTP)
admin.site.register(PasswordResetToken)


