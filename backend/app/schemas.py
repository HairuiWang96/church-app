"""
Data Validation Schemas for the Church App
This file defines Pydantic models for request/response validation.
These schemas ensure that data is in the correct format before it reaches the database.
"""

from pydantic import BaseModel, EmailStr, Field, validator
from datetime import datetime
from typing import Optional
from .models import UserRole


class UserBase(BaseModel):
    """
    Base User schema with common attributes.
    Used as a foundation for other user-related schemas.
    """
    email: EmailStr      # Validates that the email is in correct format
    # User's first name
    first_name: str = Field(..., min_length=1, max_length=50)
    # User's last name
    last_name: str = Field(..., min_length=1, max_length=50)
    phone_number: Optional[str] = Field(
        None, pattern=r'^\+?1?\d{9,15}$')  # Optional phone number
    address: Optional[str] = Field(
        None, max_length=200)           # Optional address
    address2: Optional[str] = Field(
        None, max_length=100)           # Optional secondary address
    city: Optional[str] = Field(
        None, max_length=100)           # Optional city
    state: Optional[str] = Field(
        None, max_length=50)            # Optional state
    role: UserRole = UserRole.MEMBER                              # User role
    # Optional date of birth
    date_of_birth: Optional[datetime] = None

    @validator('first_name', 'last_name')
    def name_must_be_valid(cls, v):
        """Validate that names contain only letters and spaces"""
        if not all(c.isalpha() or c.isspace() for c in v):
            raise ValueError('Name must contain only letters and spaces')
        return v.title()  # Capitalize first letter of each word


class UserCreate(UserBase):
    """
    Schema for creating a new user.
    Extends UserBase to include password field.
    """
    password: str = Field(..., min_length=8,
                          max_length=50)  # Password with length validation


class UserUpdate(BaseModel):
    """
    Schema for updating a user.
    All fields are optional.
    """
    email: Optional[EmailStr] = None
    first_name: Optional[str] = Field(None, min_length=1, max_length=50)
    last_name: Optional[str] = Field(None, min_length=1, max_length=50)
    phone_number: Optional[str] = Field(None, pattern=r'^\+?1?\d{9,15}$')
    address: Optional[str] = Field(None, max_length=200)
    address2: Optional[str] = Field(None, max_length=100)
    city: Optional[str] = Field(None, max_length=100)
    state: Optional[str] = Field(None, max_length=50)
    role: Optional[UserRole] = None
    date_of_birth: Optional[datetime] = None
    is_active: Optional[bool] = None

    @validator('first_name', 'last_name')
    def name_must_be_valid(cls, v):
        """Validate that names contain only letters and spaces"""
        if v is not None and not all(c.isalpha() or c.isspace() for c in v):
            raise ValueError('Name must contain only letters and spaces')
        return v.title() if v is not None else v


class User(UserBase):
    """
    Schema for user responses.
    Includes all fields that come from the database.
    """
    id: int             # User's unique identifier
    is_active: bool     # Whether the user account is active
    join_date: datetime  # When the user joined
    created_at: datetime  # When the user was created
    updated_at: datetime  # When the user was last updated

    class Config:
        # Allows conversion from database model to Pydantic model
        from_attributes = True


class EventBase(BaseModel):
    """
    Base Event schema with common attributes.
    Used as a foundation for other event-related schemas.
    """
    title: str = Field(..., min_length=1, max_length=100)         # Event title
    description: Optional[str] = Field(
        None, max_length=500)      # Optional event description
    # When the event will occur
    event_date: datetime
    location: Optional[str] = Field(
        None, max_length=200)         # Optional event location


class EventCreate(EventBase):
    """
    Schema for creating a new event.
    Currently identical to EventBase, but can be extended if needed.
    """
    pass


class Event(EventBase):
    """
    Schema for event responses.
    Includes all fields that come from the database.
    """
    id: int             # Event's unique identifier
    created_at: datetime  # When the event was created
    updated_at: datetime  # When the event was last updated

    class Config:
        # Allows conversion from database model to Pydantic model
        from_attributes = True
