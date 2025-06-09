"""
Database Configuration for the Church App
This file handles database connection and session management using SQLAlchemy.
It provides the database engine and session factory for the application.
"""

from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import os
from dotenv import load_dotenv

# Load environment variables from .env file
# This allows us to keep sensitive information like database URLs out of the code
load_dotenv()

# Get the database URL from environment variables
# If not found, use SQLite as a default (good for development)
SQLALCHEMY_DATABASE_URL = os.getenv(
    "DATABASE_URL", "sqlite:///./church_app.db")

# Create the SQLAlchemy engine
# This is the main entry point for database operations
engine = create_engine(
    SQLALCHEMY_DATABASE_URL,
    # This argument is needed for SQLite to allow multiple threads
    connect_args={"check_same_thread": False}
)

# Create a session factory
# This will be used to create database sessions
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Create a base class for declarative models
Base = declarative_base()

# Dependency function for FastAPI
# This function will be used to get database sessions in route handlers


def get_db():
    """
    Creates a new database session for a request.
    Ensures the session is closed after the request is complete.
    """
    db = SessionLocal()
    try:
        yield db  # Provide the database session to the route handler
    finally:
        db.close()  # Always close the session, even if an error occurs
