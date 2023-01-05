package repository

/*
厦门大学计算机专业 | 前华为工程师
专注《零基础学编程系列》  http://lblbc.cn/blog
包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
公众号：蓝不蓝编程
*/
import (
	"gorm.io/gorm"
	"lblbc.cn/blog/entity"
)

type BlogRepository interface {
	QueryBlogs() []entity.Blog
	QueryByID(bookID uint64) entity.Blog
	AddBlog(b entity.Blog) entity.Blog
	ModifyBlog(b entity.Blog) entity.Blog
	DeleteBlog(b entity.Blog)
}

type dbConnection struct {
	connection *gorm.DB
}

func NewBlogRepository(connection *gorm.DB) BlogRepository {
	return &dbConnection{connection: connection}
}

func (db *dbConnection) QueryByID(bookID uint64) entity.Blog {
	var book entity.Blog                              // create variable book
	db.connection.Preload("User").Find(&book, bookID) // get data book from bookID and preload user from book
	return book                                       // return book
}

func (db *dbConnection) QueryBlogs() []entity.Blog {
	var blogs []entity.Blog
	db.connection.Preload("User").Find(&blogs)
	return blogs
}

func (db *dbConnection) AddBlog(b entity.Blog) entity.Blog {
	db.connection.Save(&b)
	db.connection.Preload("User").Find(&b)
	return b
}

func (db *dbConnection) ModifyBlog(b entity.Blog) entity.Blog {
	db.connection.Save(&b)
	db.connection.Preload("User").Find(&b)
	return b
}

func (db *dbConnection) DeleteBlog(b entity.Blog) {
	db.connection.Delete(&b)
}
