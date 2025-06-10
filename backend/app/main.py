"""
Main Application File for the Church App
This file defines the FastAPI application and all API endpoints.
It handles HTTP requests and responses, and coordinates with the database.
"""

from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session
from typing import List
from datetime import datetime

from . import models, schemas
from .database import engine, get_db

# Create FastAPI application
app = FastAPI(title="Church App API")

# Configure CORS (Cross-Origin Resource Sharing)
# This allows Flutter app to communicate with the backend
app.add_middleware(
    CORSMiddleware,
    # In production, replace "*" with Flutter app's domain
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def root():
    """
    Root endpoint - Welcome message
    """
    return {"message": "Welcome to Church App API"}


@app.get("/health")
async def health_check():
    """
    Health check endpoint
    Used to verify that the API is running
    """
    return {"status": "healthy"}


# User Management Endpoints
@app.post("/users/", response_model=schemas.User, status_code=status.HTTP_201_CREATED)
def create_user(user: schemas.UserCreate, db: Session = Depends(get_db)):
    """
    Create a new user
    - Validates the user data
    - Checks if email is already registered
    - Creates new user in database
    """
    # Check if user with this email already exists
    db_user = db.query(models.User).filter(
        models.User.email == user.email).first()
    if db_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Email already registered"
        )

    # Create new user
    # TODO: Add password hashing for security
    db_user = models.User(
        email=user.email,
        first_name=user.first_name,
        last_name=user.last_name,
        phone_number=user.phone_number,
        address=user.address,
        address2=user.address2,
        city=user.city,
        state=user.state,
        role=user.role,
        date_of_birth=user.date_of_birth,
        hashed_password=user.password  # This should be hashed in production
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user


@app.get("/users/", response_model=List[schemas.User])
def read_users(
    skip: int = 0,
    limit: int = 100,
    role: models.UserRole = None,
    is_active: bool = None,
    city: str = None,
    state: str = None,
    db: Session = Depends(get_db)
):
    """
    Get list of users
    - Supports pagination with skip and limit
    - Can filter by role, active status, city, and state
    - Returns list of users
    """
    query = db.query(models.User)

    # Apply filters if provided
    if role is not None:
        query = query.filter(models.User.role == role)
    if is_active is not None:
        query = query.filter(models.User.is_active == is_active)
    if city is not None:
        query = query.filter(models.User.city.ilike(f"%{city}%"))
    if state is not None:
        query = query.filter(models.User.state.ilike(f"%{state}%"))

    # Apply pagination
    users = query.offset(skip).limit(limit).all()
    return users


@app.get("/users/{user_id}", response_model=schemas.User)
def read_user(user_id: int, db: Session = Depends(get_db)):
    """
    Get a specific user by ID
    """
    db_user = db.query(models.User).filter(models.User.id == user_id).first()
    if db_user is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found"
        )
    return db_user


@app.put("/users/{user_id}", response_model=schemas.User)
def update_user(
    user_id: int,
    user_update: schemas.UserUpdate,
    db: Session = Depends(get_db)
):
    """
    Update a user's information
    - Only updates provided fields
    - Validates all updates
    """
    db_user = db.query(models.User).filter(models.User.id == user_id).first()
    if db_user is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found"
        )

    # Update only provided fields
    update_data = user_update.model_dump(exclude_unset=True)
    for field, value in update_data.items():
        setattr(db_user, field, value)

    db.commit()
    db.refresh(db_user)
    return db_user


@app.delete("/users/{user_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_user(user_id: int, db: Session = Depends(get_db)):
    """
    Delete a user
    - Permanently removes the user from the database
    """
    db_user = db.query(models.User).filter(models.User.id == user_id).first()
    if db_user is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found"
        )

    db.delete(db_user)
    db.commit()
    return None


# Event Management Endpoints
@app.post("/events/", response_model=schemas.Event)
def create_event(event: schemas.EventCreate, db: Session = Depends(get_db)):
    """
    Create a new event
    - Validates the event data
    - Creates new event in database
    """
    db_event = models.Event(**event.model_dump())
    db.add(db_event)
    db.commit()
    db.refresh(db_event)
    return db_event


@app.get("/events/", response_model=List[schemas.Event])
def read_events(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    """
    Get list of events
    - Supports pagination with skip and limit
    - Returns list of events
    """
    events = db.query(models.Event).offset(skip).limit(limit).all()
    return events
