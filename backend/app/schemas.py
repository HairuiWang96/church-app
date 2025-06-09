"""
Data Validation Schemas for the Church App
This file defines Pydantic models for request/response validation.
These schemas ensure that data is in the correct format before it reaches the database.
"""

from pydantic import BaseModel, EmailStr
from datetime import datetime
from typing import Optional


class UserBase(BaseModel):
    """
    Base User schema with common attributes.
    Used as a foundation for other user-related schemas.
    """
    email: EmailStr      # Validates that the email is in correct format
    full_name: str       # User's full name


class UserCreate(UserBase):
    """
    Schema for creating a new user.
    Extends UserBase to include password field.
    """
    password: str        # Password for the new user


class User(UserBase):
    """
    Schema for user responses.
    Includes all fields that come from the database.
    """
    id: int             # User's unique identifier
    is_active: bool     # Whether the user account is active
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
    title: str                          # Event title
    description: Optional[str] = None   # Optional event description
    event_date: datetime                # When the event will occur
    location: Optional[str] = None      # Optional event location


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
