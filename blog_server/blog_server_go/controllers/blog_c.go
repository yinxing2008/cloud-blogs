package controllers

/*
厦门大学计算机专业 | 前华为工程师
专注《零基础学编程系列》  http://lblbc.cn/blog
包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
公众号：蓝不蓝编程
*/
import (
	"fmt"
	"net/http"
	"strconv"

	"github.com/dgrijalva/jwt-go"
	"github.com/gin-gonic/gin"
	"lblbc.cn/blog/dto"
	"lblbc.cn/blog/entity"
	"lblbc.cn/blog/helper"
	"lblbc.cn/blog/services"
)

type BlogController interface {
	QueryBlogs(c *gin.Context)
	QueryById(c *gin.Context)
	AddBlog(c *gin.Context)
	ModifyBlog(c *gin.Context)
	DeleteBlog(c *gin.Context)
}

type blogController struct {
	blogService services.BlogService
	jwtService  services.JWTService
}

func NewBlogController(blogService services.BlogService, jwtServ services.JWTService) BlogController {
	return &blogController{blogService: blogService, jwtService: jwtServ}
}

func (c *blogController) QueryById(ctx *gin.Context) {
	blogId, err := strconv.ParseUint(ctx.Param("id"), 10, 64)
	if err != nil {
		response := helper.ErrorsResponse(-1, err.Error(), helper.EmptyObject{})
		ctx.AbortWithStatusJSON(http.StatusBadRequest, response)
		return
	}
	var blog entity.Blog = c.blogService.QueryById(blogId)
	if blog == (entity.Blog{}) {
		response := helper.ErrorsResponse(-1, "Blog Not Found", helper.EmptyObject{})
		ctx.AbortWithStatusJSON(http.StatusNotFound, response)
		return
	} else {
		response := helper.SuccessResponse(0, "", blog)
		ctx.JSON(http.StatusOK, response)
	}
}

func (c *blogController) QueryBlogs(ctx *gin.Context) {
	var blog []entity.Blog = c.blogService.QueryBlogs()
	response := helper.SuccessResponse(0, "", blog)
	ctx.JSON(http.StatusOK, response)
}

func (c *blogController) AddBlog(ctx *gin.Context) {
	var blogCreateDTO dto.BlogCreateDTORequest
	errDTO := ctx.ShouldBind(&blogCreateDTO)
	if errDTO != nil {
		response := helper.ErrorsResponse(-1, errDTO.Error(), helper.EmptyObject{})
		ctx.AbortWithStatusJSON(http.StatusBadRequest, response)
		return
	}
	authHeader := ctx.GetHeader("Authorization")
	userID := c.getUserIDByToken(authHeader)
	id, err := strconv.ParseUint(userID, 10, 64)
	if err == nil {
		blogCreateDTO.UserID = id
	}
	result := c.blogService.AddBlog(blogCreateDTO)
	response := helper.SuccessResponse(0, "", result)
	ctx.JSON(http.StatusCreated, response)
}

func (c *blogController) ModifyBlog(ctx *gin.Context) {
	blogId, _ := strconv.ParseUint(ctx.Param("id"), 10, 64)
	var blogUpdateDTO dto.BlogUpdateDTORequest
	errDTO := ctx.ShouldBind(&blogUpdateDTO)
	blogUpdateDTO.ID = blogId
	if errDTO != nil {
		result := helper.ErrorsResponse(-1, errDTO.Error(), helper.EmptyObject{})
		ctx.AbortWithStatusJSON(http.StatusBadRequest, result)
		return
	}
	authHeader := ctx.GetHeader("Authorization")
	token, errToken := c.jwtService.ValidateToken(authHeader)
	if errToken != nil {
		panic(errToken.Error())
	}
	claims := token.Claims.(jwt.MapClaims)
	userID := fmt.Sprintf("%v", claims["user_id"])
	id, errID := strconv.ParseUint(userID, 10, 64)
	if errID == nil {
		blogUpdateDTO.UserID = id
	}
	result := c.blogService.ModifyBlog(blogUpdateDTO)
	response := helper.SuccessResponse(0, "Update Data Blog", result)
	ctx.JSON(http.StatusOK, response)
}

func (c *blogController) DeleteBlog(ctx *gin.Context) {
	var blog entity.Blog
	id, err := strconv.ParseUint(ctx.Param("id"), 10, 64)
	if err != nil {
		response := helper.ErrorsResponse(-1, err.Error(), helper.EmptyObject{})
		ctx.AbortWithStatusJSON(http.StatusBadRequest, response)
		return
	}
	blog.ID = id
	authHeader := ctx.GetHeader("Authorization")
	_, errToken := c.jwtService.ValidateToken(authHeader)
	if errToken != nil {
		panic(errToken.Error())
	}
	c.blogService.DeleteBlog(blog)
	response := helper.SuccessResponse(0, "", "")
	ctx.JSON(http.StatusOK, response)
}

func (c *blogController) getUserIDByToken(token string) string {
	myToken, err := c.jwtService.ValidateToken(token)
	if err != nil {
		panic(err.Error())
	}
	claims := myToken.Claims.(jwt.MapClaims)
	return claims["user_id"].(string)
}
