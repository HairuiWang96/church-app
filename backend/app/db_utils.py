"""
Database Utility Functions for the Church App
This file contains helper functions for common database operations.
"""

from sqlalchemy.orm import Session
from datetime import datetime
from typing import List, Optional
from . import models, schemas


def get_user_by_email(db: Session, email: str):
    """
    Get a user by their email address
    """
    return db.query(models.User).filter(models.User.email == email).first()


def get_user_by_id(db: Session, user_id: int):
    """
    Get a user by their ID
    """
    return db.query(models.User).filter(models.User.id == user_id).first()


def get_users(
    db: Session,
    skip: int = 0,
    limit: int = 100,
    role: Optional[models.UserRole] = None,
    is_active: Optional[bool] = None,
    city: Optional[str] = None,
    state: Optional[str] = None
) -> List[models.User]:
    """
    Get a list of users with optional filtering
    """
    query = db.query(models.User)

    if role is not None:
        query = query.filter(models.User.role == role)
    if is_active is not None:
        query = query.filter(models.User.is_active == is_active)
    if city is not None:
        query = query.filter(models.User.city.ilike(f"%{city}%"))
    if state is not None:
        query = query.filter(models.User.state.ilike(f"%{state}%"))

    return query.offset(skip).limit(limit).all()


def create_user(db: Session, user: schemas.UserCreate) -> models.User:
    """
    Create a new user
    """
    # TODO: Add password hashing
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
        hashed_password=user.password,  # This should be hashed in production
        is_active=True,
        join_date=datetime.utcnow()
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user


def update_user(
    db: Session,
    user_id: int,
    user_update: schemas.UserUpdate
) -> Optional[models.User]:
    """
    Update a user's information
    """
    db_user = get_user_by_id(db, user_id)
    if db_user is None:
        return None

    # Update only provided fields
    update_data = user_update.model_dump(exclude_unset=True)
    for field, value in update_data.items():
        setattr(db_user, field, value)

    db.commit()
    db.refresh(db_user)
    return db_user


def delete_user(db: Session, user_id: int) -> bool:
    """
    Delete a user
    Returns True if the user was deleted, False if not found
    """
    db_user = get_user_by_id(db, user_id)
    if db_user is None:
        return False

    db.delete(db_user)
    db.commit()
    return True


def create_event(db: Session, event: schemas.EventCreate) -> models.Event:
    """
    Create a new event
    """
    db_event = models.Event(**event.model_dump())
    db.add(db_event)
    db.commit()
    db.refresh(db_event)
    return db_event


def get_events(
    db: Session,
    skip: int = 0,
    limit: int = 100
) -> List[models.Event]:
    """
    Get a list of events
    """
    return db.query(models.Event).offset(skip).limit(limit).all()
