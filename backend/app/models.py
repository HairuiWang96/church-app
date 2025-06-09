"""
Database Models for the Church App
This file defines the database structure using SQLAlchemy ORM (Object-Relational Mapping).
Each class represents a table in the database, and each attribute represents a column.
"""

from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, Boolean
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from datetime import datetime

# Create a base class for all models
Base = declarative_base()


class User(Base):
    """
    User model representing the users table in the database.
    Stores information about church members and administrators.
    """
    __tablename__ = "users"  # This will be the table name in the database

    # Primary key, auto-incrementing ID
    id = Column(Integer, primary_key=True, index=True)

    # User's email address (must be unique)
    email = Column(String, unique=True, index=True)

    # Password will be stored in hashed form for security
    hashed_password = Column(String)

    # User's full name
    full_name = Column(String)

    # Account status (active/inactive)
    is_active = Column(Boolean, default=True)

    # Timestamps for record keeping
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow,
                        onupdate=datetime.utcnow)


class Event(Base):
    """
    Event model representing the events table in the database.
    Stores information about church events, services, and activities.
    """
    __tablename__ = "events"  # This will be the table name in the database

    # Primary key, auto-incrementing ID
    id = Column(Integer, primary_key=True, index=True)

    # Event title (indexed for faster searches)
    title = Column(String, index=True)

    # Detailed description of the event
    description = Column(String)

    # When the event is scheduled to occur
    event_date = Column(DateTime)

    # Where the event will take place
    location = Column(String)

    # Timestamps for record keeping
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow,
                        onupdate=datetime.utcnow)
