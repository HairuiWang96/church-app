"""
Database Configuration for the Church App
This file handles database connection and session management.
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

# Create SQLAlchemy engine
# connect_args is needed for SQLite
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
    Database dependency for FastAPI endpoints.
    Yields a database session and ensures it's closed after use.
    """
    db = SessionLocal()
    try:
        yield db  # Provide the database session to the route handler
    finally:
        db.close()  # Always close the session, even if an error occurs
