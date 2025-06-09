"""
Database Utility Script
This script provides functions to interact with the database directly.
Useful for development and testing.
"""

from app.database import SessionLocal
from app.models import User, Event
from datetime import datetime
import requests
import json


def create_user_api(email: str, full_name: str, password: str):
    """
    Create a new user using the API endpoint
    """
    url = "http://localhost:8000/users/"
    data = {
        "email": email,
        "full_name": full_name,
        "password": password
    }

    try:
        response = requests.post(url, json=data)
        response.raise_for_status()  # Raise an exception for bad status codes
        print("User created successfully!")
        print(json.dumps(response.json(), indent=2))
        return response.json()
    except requests.exceptions.RequestException as e:
        print(f"Error creating user: {e}")
        return None


def add_sample_data():
    """Add sample data to the database"""
    db = SessionLocal()
    try:
        # Add sample users
        users = [
            User(
                email="john@example.com",
                full_name="John Doe",
                hashed_password="password123",  # In production, this should be hashed
                is_active=True
            ),
            User(
                email="jane@example.com",
                full_name="Jane Smith",
                hashed_password="password456",
                is_active=True
            )
        ]

        # Add sample events
        events = [
            Event(
                title="Sunday Service",
                description="Weekly Sunday service",
                # June 24, 2025, 10:00 AM
                event_date=datetime(2025, 6, 24, 10, 0),
                location="Main Hall"
            ),
            Event(
                title="Bible Study",
                description="Weekly Bible study group",
                # June 27, 2025, 7:00 PM
                event_date=datetime(2025, 6, 27, 19, 0),
                location="Room 101"
            )
        ]

        # Add all items to database
        db.add_all(users)
        db.add_all(events)
        db.commit()
        print("Sample data added successfully!")

    except Exception as e:
        print(f"Error adding sample data: {e}")
        db.rollback()
    finally:
        db.close()


def view_all_data():
    """View all data in the database"""
    db = SessionLocal()
    try:
        # Get all users
        print("\n=== Users ===")
        users = db.query(User).all()
        for user in users:
            print(f"ID: {user.id}")
            print(f"Name: {user.full_name}")
            print(f"Email: {user.email}")
            print(f"Active: {user.is_active}")
            print(f"Created: {user.created_at}")
            print("---")

        # Get all events
        print("\n=== Events ===")
        events = db.query(Event).all()
        for event in events:
            print(f"ID: {event.id}")
            print(f"Title: {event.title}")
            print(f"Description: {event.description}")
            print(f"Date: {event.event_date}")
            print(f"Location: {event.location}")
            print("---")

    except Exception as e:
        print(f"Error viewing data: {e}")
    finally:
        db.close()


if __name__ == "__main__":
    # Uncomment the line below to add sample data
    # add_sample_data()

    # Example of creating a user through the API
    create_user_api(
        email="testuser@example.com",
        full_name="Test User",
        password="testpass123"
    )

    # View all data
    view_all_data()
