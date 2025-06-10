"""
Example usage of database utility functions
This file demonstrates how to use the functions in db_utils.py
"""

from datetime import datetime
from .database import SessionLocal
from . import schemas
from .db_utils import (
    create_user,
    get_user_by_email,
    get_user_by_id,
    get_users,
    update_user,
    delete_user,
    create_event,
    get_events
)


def example_create_user():
    """Example of creating a new user"""
    db = SessionLocal()
    try:
        # Create a new user with all fields
        new_user = create_user(
            db,
            schemas.UserCreate(
                email="john.doe@example.com",
                first_name="John",
                last_name="Doe",
                phone_number="+1234567890",
                address="123 Main Street",
                address2="Apt 4B",
                city="New York",
                state="NY",
                password="securepassword123",
                role="member",
                date_of_birth=datetime(1990, 1, 1)
            )
        )
        print(f"Created user: {new_user.email}")
        return new_user
    finally:
        db.close()


def example_get_users():
    """Example of getting users with filters"""
    db = SessionLocal()
    try:
        # Get all users
        all_users = get_users(db)
        print(f"Total users: {len(all_users)}")

        # Get users in New York
        ny_users = get_users(db, city="New York")
        print(f"Users in New York: {len(ny_users)}")

        # Get active members
        active_members = get_users(
            db,
            role="member",
            is_active=True
        )
        print(f"Active members: {len(active_members)}")

        # Get users with pagination
        first_page = get_users(db, skip=0, limit=10)
        second_page = get_users(db, skip=10, limit=10)
        print(f"First page users: {len(first_page)}")
        print(f"Second page users: {len(second_page)}")
    finally:
        db.close()


def example_update_user(user_id: int):
    """Example of updating a user"""
    db = SessionLocal()
    try:
        # Update user's address information
        updated_user = update_user(
            db,
            user_id,
            schemas.UserUpdate(
                address="456 New Street",
                address2="Suite 100",
                city="Brooklyn",
                state="NY"
            )
        )
        if updated_user:
            print(f"Updated user: {updated_user.email}")
            print(f"New address: {updated_user.address}, {updated_user.city}")
        else:
            print("User not found")
    finally:
        db.close()


def example_create_event():
    """Example of creating an event"""
    db = SessionLocal()
    try:
        # Create a new event
        new_event = create_event(
            db,
            schemas.EventCreate(
                title="Sunday Service",
                description="Weekly Sunday service with worship and sermon",
                # June 16, 2024, 10:00 AM
                event_date=datetime(2024, 6, 16, 10, 0),
                location="Main Hall"
            )
        )
        print(f"Created event: {new_event.title}")
        return new_event
    finally:
        db.close()


def example_get_events():
    """Example of getting events"""
    db = SessionLocal()
    try:
        # Get all events
        events = get_events(db)
        print(f"Total events: {len(events)}")

        # Get events with pagination
        first_page = get_events(db, skip=0, limit=5)
        print(f"First page events: {len(first_page)}")
    finally:
        db.close()


if __name__ == "__main__":
    # Create a new user
    user = example_create_user()

    # Get users with various filters
    example_get_users()

    # Update the user we just created
    if user:
        example_update_user(user.id)

    # Create and get events
    example_create_event()
    example_get_events()
