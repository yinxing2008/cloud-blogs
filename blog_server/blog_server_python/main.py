from fastapi import FastAPI, Depends, HTTPException, Response
from starlette.middleware.cors import CORSMiddleware

import dao, networkModels
from database import SessionLocal, engine, Base
from sqlalchemy.orm import Session
import uvicorn

from login import check_token, create_token

Base.metadata.create_all(bind=engine)  # 数据库初始化，如果没有库或者表，会自动创建

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    # 允许跨域的源列表，例如 ["http://www.example.org"] 等等，["*"] 表示允许任何源
    allow_origins=["*"],
    # 跨域请求是否支持 cookie，默认是 False，如果为 True，allow_origins 必须为具体的源，不可以是 ["*"]
    allow_credentials=False,
    # 允许跨域请求的 HTTP 方法列表，默认是 ["GET"]
    allow_methods=["*"],
    # 允许跨域请求的 HTTP 请求头列表，默认是 []，可以使用 ["*"] 表示允许所有的请求头
    # 当然 Accept、Accept-Language、Content-Language 以及 Content-Type 总之被允许的
    allow_headers=["*"],
    # 可以被浏览器访问的响应头, 默认是 []，一般很少指定
    # expose_headers=["*"]
    # 设定浏览器缓存 CORS 响应的最长时间，单位是秒。默认为 600，一般也很少指定
    # max_age=1000
)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


# 登录
@app.post("/user/login", response_model=networkModels.LoginResp)
async def login(request: networkModels.LoginRequest, db: Session = Depends(get_db)):
    db_user = dao.check_user(db=db, user_name=request.name, user_password=request.password)
    if db_user:
        token = create_token(db_user.id)
        return {"code": 0, "msg": "", "data": {"token": token}}
    else:
        return {"code": -1, "msg": "用户名或密码错误"}


# 注册
@app.post("/user/register", response_model=networkModels.LoginResp)
def register(request: networkModels.LoginRequest, db: Session = Depends(get_db)):
    db_user = dao.get_user_by_name(db=db, user_name=request.name)
    if db_user:
        return {"code": -1, "msg": "用户已存在"}
    else:
        db_user = dao.create_user(db=db, request=request)
        token = create_token(db_user.id)
        return {"code": 0, "msg": "", "data": {"token": token}}


@app.get("/blog/blogs/{blog_id}", response_model=networkModels.QueryBlogResp)
def query_blog(blog_id: int, db: Session = Depends(get_db)):
    blog = dao.query_blog(db=db, blog_id=blog_id)
    return {"code": 0, "msg": "", "data": {"id": blog.id, "title": blog.title, "content": blog.content}}


@app.get("/blog/blogs", response_model=networkModels.QueryBlogListResp)
def query_user_blogs(db: Session = Depends(get_db), user_id=Depends(check_token)):
    blogs = dao.query_user_blogs(db=db, user_id=user_id)
    return {"code": 0, "msg": "", "data": blogs}


@app.post("/blog/blogs", response_model=networkModels.BaseResponse)
def add_blog(request: networkModels.AddBlogRequest, db: Session = Depends(get_db), user_id=Depends(check_token)):
    dao.add_blog(db=db, user_id=user_id, title=request.title, content=request.content)
    return {"code": 0, "msg": ""}


@app.put("/blog/blogs/{blog_id}", response_model=networkModels.BaseResponse)
def modify_blog(blog_id: int, request: networkModels.ModifyBlogRequest, db: Session = Depends(get_db), user_id=Depends(check_token)):
    dao.modify_blog(db=db, blog_id=blog_id, title=request.title, content=request.content)
    return {"code": 0, "msg": ""}


@app.delete("/blog/blogs/{blog_id}", response_model=networkModels.BaseResponse)
def delete_blog(blog_id: int, db: Session = Depends(get_db), user_id=Depends(check_token)):
    dao.delete_blog(db=db, blog_id=blog_id)
    return {"code": 0, "msg": ""}


if __name__ == '__main__':
    uvicorn.run(app=app, host="192.168.31.10", port=8080)
