package repository

/*
厦门大学计算机专业 | 前华为工程师
专注《零基础学编程系列》  http://lblbc.cn/blog
包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
公众号：蓝不蓝编程
*/
import (
	"log"

	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
	"lblbc.cn/blog/entity"
)

type UserRepository interface {
	InsertUser(user entity.User) entity.User

	UpdateUser(user entity.User) entity.User

	VerifyUser(name string, password string) interface{}

	IsUserExists(name string) (tx *gorm.DB)

	FindByName(name string) entity.User

	ProfileUser(userID int64) entity.User
}

type userConnection struct {
	connection *gorm.DB //connection to db with gorm
}

func NewUserRepository(db *gorm.DB) UserRepository {
	return &userConnection{
		connection: db,
	}
}

func (db *userConnection) InsertUser(user entity.User) entity.User {
	user.Password = hashAndSalt([]byte(user.Password))
	db.connection.Save(&user)
	return user
}

func (db *userConnection) UpdateUser(user entity.User) entity.User {
	if user.Password != "" {
		user.Password = hashAndSalt([]byte(user.Password)) //hash password
	} else {
		var tempUser entity.User               //get user from db
		db.connection.Find(&tempUser, user.ID) //find user by id
		user.Password = tempUser.Password      //set password to user
	}
	db.connection.Save(&user) //save user to db
	return user
}

func (db *userConnection) VerifyUser(name string, password string) interface{} {
	var user entity.User
	res := db.connection.Where("name = ?", name).Take(&user)
	if res.Error == nil {
		return user
	}
	return nil
}

func (db *userConnection) IsUserExists(name string) (tx *gorm.DB) {
	var user entity.User
	return db.connection.Where("name = ?", name).Take(&user)
}

func (db *userConnection) FindByName(name string) entity.User {
	var user entity.User
	db.connection.Where("name = ?", name).Take(&user)
	return user
}

func (db *userConnection) ProfileUser(userID int64) entity.User {
	var user entity.User                                                   // get user from db
	db.connection.Preload("Blog").Preload("Blog.User").Find(&user, userID) //find user by id and preload books and user
	return user                                                            //return user
}

func hashAndSalt(pwd []byte) string {
	hash, err := bcrypt.GenerateFromPassword(pwd, bcrypt.MinCost) //hash password
	if err != nil {
		log.Println(err)
		panic("Failed to hash a password") //panic if failed to hash password
	}
	return string(hash) //return hashed password
}
