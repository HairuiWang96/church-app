# Church App Backend

This is the backend service for the Church App, built with FastAPI.

## Setup

1. Create a virtual environment:

```bash
python -m venv venv
```

2. Activate the virtual environment:

-   On macOS/Linux:

```bash
source venv/bin/activate
```

-   On Windows:

```bash
.\venv\Scripts\activate
```

3. Install dependencies:

```bash
pip install -r requirements.txt
```

## Running the Server

To run the development server:

```bash
uvicorn app.main:app --reload
```

The server will start at `http://localhost:8000`

## API Documentation

Once the server is running, you can access:

-   Interactive API docs (Swagger UI): `http://localhost:8000/docs`
-   Alternative API docs (ReDoc): `http://localhost:8000/redoc`
