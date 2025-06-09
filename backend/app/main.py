from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(title="Church App API")

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    # In production, replace with your Flutter app's domain
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def root():
    return {"message": "Welcome to Church App API"}


@app.get("/health")
async def health_check():
    return {"status": "healthy"}
