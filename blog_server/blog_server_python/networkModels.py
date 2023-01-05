from pydantic import BaseModel
from typing import List, Optional


class BaseResponse(BaseModel):
    code: int
    msg: str


class LoginRequest(BaseModel):
    """
    请求模型验证：
    name:
    password:
    """
    name: str
    password: str


class AddBlogRequest(BaseModel):
    title: str
    content: str


class ModifyBlogRequest(BaseModel):
    title: str
    content: str


class Token(BaseModel):
    token: str


class LoginResp(BaseResponse):
    data: Token = None


class BlogInfo(BaseModel):
    id: int
    title: str
    content: str


class QueryBlogResp(BaseResponse):
    data: BlogInfo = None


class QueryBlogListResp(BaseResponse):
    data: List[BlogInfo] = None


class QueryUserResp(BaseModel):
    name: str
    id: int

    class Config:
        orm_mode = True
