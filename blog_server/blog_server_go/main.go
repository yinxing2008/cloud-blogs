package main

import (
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
	"lblbc.cn/blog/config"
	"lblbc.cn/blog/controllers"
	"lblbc.cn/blog/middleware"
	"lblbc.cn/blog/repository"
	"lblbc.cn/blog/services"
)

var (
	db              *gorm.DB                   = config.SetupDatabase()
	userRepository  repository.UserRepository  = repository.NewUserRepository(db)
	blogRepository  repository.BlogRepository  = repository.NewBlogRepository(db)
	jwtService      services.JWTService        = services.NewJWTService()
	userService     services.UserService       = services.NewUserService(userRepository)
	blogService     services.BlogService       = services.NewBookService(blogRepository)
	authService     services.LoginService      = services.NewAuthService(userRepository)
	loginController                            = controllers.NewLoginController(authService, jwtService)
	userController  controllers.UserController = controllers.NewUserController(userService, jwtService)
	blogController  controllers.BlogController = controllers.NewBlogController(blogService, jwtService)
)

func main() {
	defer config.CloseDatabaseConnection(db)
	r := gin.Default()

	authRoutes := r.Group("/user")
	{
		authRoutes.POST("/login", loginController.Login)
		authRoutes.POST("/register", loginController.Register)
	}

	blogRoutes := r.Group("blog/blogs", middleware.AuthorizeJWT(jwtService))
	{
		blogRoutes.GET("/", blogController.QueryBlogs)
		blogRoutes.GET("/:id", blogController.QueryById)
		blogRoutes.POST("/", blogController.AddBlog)
		blogRoutes.PUT("/:id", blogController.ModifyBlog)
		blogRoutes.DELETE("/:id", blogController.DeleteBlog)
	}

	r.Run(":8080")

}
