from sqlalchemy.orm import Session
from sqlalchemy.future import select
import models, networkModels


def get_user_by_name(db: Session, user_name: str):
    return db.query(models.User).filter(models.User.name == user_name).first()


def check_user(db: Session, user_name: str, user_password: str):
    return db.query(models.User).filter(models.User.name == user_name and models.User.password == user_password).first()


# 新建用户
def create_user(db: Session, request: networkModels.LoginRequest):
    db_user = models.User(name=request.name, password=request.password)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user


def query_blog(db: Session, blog_id: int):
    return db.query(models.Blog).filter(models.Blog.id == blog_id).first()


def query_user_blogs(db: Session, user_id: int):
    sql = select(models.Blog.id,models.Blog.title,models.Blog.content).where(models.Blog.user_id == user_id)
    q = db.execute(sql)
    return q.all()


def add_blog(db: Session, user_id: int, title: str, content: str):
    db_blog = models.Blog(user_id=user_id, title=title, content=content)
    db.add(db_blog)
    db.commit()
    db.refresh(db_blog)
    return db_blog


def modify_blog(db: Session, blog_id: int, title: str, content: str):
    db_blog = db.query(models.Blog).filter(models.Blog.id == blog_id).first()
    db_blog.title = title
    db_blog.content = content
    db.commit()
    db.refresh(db_blog)
    return db_blog


def delete_blog(db: Session, blog_id: int):
    db.query(models.Blog).filter(models.Blog.id == blog_id).delete()
    db.commit()
    return 0
