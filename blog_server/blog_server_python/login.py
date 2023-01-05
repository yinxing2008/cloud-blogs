from datetime import datetime, timedelta
from typing import Any, Union, Optional
from jose import jwt
from fastapi import Header

SECRET_KEY = "lblbc"
ALGORITHM = "HS256"
TOKEN_EXPIRE_MINUTES = 1000 * 24 * 60  # 默认失效时间，1000天


def create_token(subject: Union[str, Any]) -> str:
    expire = datetime.utcnow() + timedelta(
        minutes=TOKEN_EXPIRE_MINUTES
    )
    to_encode = {"exp": expire, "sub": str(subject)}
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt


def check_token(token: Optional[str] = Header(..., alias="Authorization")) -> Union[int, Any]:
    payload = jwt.decode(
        token,
        SECRET_KEY, algorithms=[ALGORITHM]
    )
    return payload.get("sub")
