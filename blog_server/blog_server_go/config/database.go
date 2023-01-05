package config

import (
	"log"
	"time"

	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
	"lblbc.cn/blog/entity"
)

func SetupDatabase() *gorm.DB {
	//dbUser := "root"
	//dbPassword := "12345678"
	//dbHost := localhost
	//dbPort := 3306
	//dbName := lblbc_blog

	// Create the connection string
	//dbURI := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8&parseTime=True&loc=Local", dbUser, dbPassword, dbHost, dbPort, dbName)

	// Open connection to the database
	//db, err := gorm.Open(mysql.Open(dbURI), &gorm.Config{})
	db, err := gorm.Open(sqlite.Open("lblbc_blog.db"), &gorm.Config{})

	if err != nil {
		log.Fatal(err)
	}

	sqlDB, err := db.DB()

	// SetMaxIdleConns sets the maximum number of connections in the idle connection pool.
	sqlDB.SetMaxIdleConns(10)

	// SetMaxOpenConns sets the maximum number of open connections to the database.
	sqlDB.SetMaxOpenConns(100)

	// SetConnMaxLifetime sets the maximum amount of time a connection may be reused.
	sqlDB.SetConnMaxLifetime(time.Hour)

	// SetConnIdleTime sets the maximum amount of time a connection may be reused.
	sqlDB.SetConnMaxLifetime(10 * time.Hour)

	// Migrate the schema
	db.AutoMigrate(&entity.User{}, &entity.Blog{})

	return db

}

func CloseDatabaseConnection(db *gorm.DB) {

	// Get the underlying sql.DB instance from the gorm.DB instance.
	dbSQL, err := db.DB()
	if err != nil {
		log.Fatal(err)
	}
	dbSQL.Close() // Close the database connection

}
