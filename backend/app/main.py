"""
Main Application File for the Church App
This file defines the FastAPI application and all API endpoints.
It handles HTTP requests and responses, and coordinates with the database.
"""

from fastapi import FastAPI, Depends, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session
from typing import List

from . import models, schemas
from .database import engine, get_db

# Create database tables based on the models
# This will create the tables if they don't exist
models.Base.metadata.create_all(bind=engine)

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
@app.post("/users/", response_model=schemas.User)
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
        raise HTTPException(status_code=400, detail="Email already registered")

    # Create new user
    # TODO: Add password hashing for security
    db_user = models.User(
        email=user.email,
        full_name=user.full_name,
        hashed_password=user.password  # This should be hashed in production
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user


@app.get("/users/", response_model=List[schemas.User])
def read_users(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    """
    Get list of users
    - Supports pagination with skip and limit
    - Returns list of users
    """
    users = db.query(models.User).offset(skip).limit(limit).all()
    return users


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
