from fastapi import FastAPI
from sqlalchemy import text

from app.core.database import engine

app = FastAPI(title="Internal Kakao Work Support Bot API", version="0.1.0")


@app.get("/health")
def health_check():
    db_ok = False
    try:
        with engine.connect() as conn:
            conn.execute(text("SELECT 1"))
            db_ok = True
    except Exception:
        db_ok = False

    return {
        "status": "ok" if db_ok else "degraded",
        "database": "ok" if db_ok else "error",
    }
