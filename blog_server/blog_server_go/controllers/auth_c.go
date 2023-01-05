package controllers

/*
厦门大学计算机专业 | 前华为工程师
专注《零基础学编程系列》  http://lblbc.cn/blog
包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
公众号：蓝不蓝编程
*/
import (
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
	"lblbc.cn/blog/dto"
	"lblbc.cn/blog/entity"
	"lblbc.cn/blog/helper"
	"lblbc.cn/blog/services"
)

type LoginController interface {
	Login(c *gin.Context)
	Register(c *gin.Context)
}

type loginController struct {
	loginService services.LoginService
	jwtService   services.JWTService
}

func NewLoginController(loginService services.LoginService, jwtService services.JWTService) LoginController {
	return &loginController{
		loginService: loginService,
		jwtService:   jwtService,
	}
}

func (c *loginController) Login(ctx *gin.Context) {
	var loginDTO dto.LoginDTORequest
	errDTO := ctx.ShouldBind(&loginDTO)
	if errDTO != nil {
		response := helper.ErrorsResponse(-1, errDTO.Error(), helper.EmptyObject{})
		ctx.AbortWithStatusJSON(http.StatusBadRequest, response)
		return
	}

	authResult := c.loginService.VerifyUser(loginDTO.Name, loginDTO.Password)

	if v, ok := authResult.(entity.User); ok {
		generatedToken := c.jwtService.GenerateToken(strconv.Itoa(int(v.ID)))
		v.Token = generatedToken
		response := helper.SuccessResponse(0, "Login Success", v)
		ctx.JSON(http.StatusOK, response)
		return
	}

	response := helper.ErrorsResponse(-1, "用户名或密码错误", helper.EmptyObject{})
	ctx.AbortWithStatusJSON(http.StatusUnauthorized, response)
}

func (c *loginController) Register(ctx *gin.Context) {

	var registerDTO dto.RegisterDTORequest

	errDTO := ctx.ShouldBind(&registerDTO)

	if errDTO != nil {
		response := helper.ErrorsResponse(-1, errDTO.Error(), helper.EmptyObject{})
		ctx.AbortWithStatusJSON(http.StatusBadRequest, response)
		return
	}

	if !c.loginService.IsUserExists(registerDTO.Name) {
		response := helper.ErrorsResponse(-1, "用户已存在", helper.EmptyObject{})
		ctx.AbortWithStatusJSON(http.StatusConflict, response)
		return
	} else {
		createdUser := c.loginService.Register(registerDTO) // create new user
		token := c.jwtService.GenerateToken(strconv.Itoa(int(createdUser.ID)))
		createdUser.Token = token
		response := helper.SuccessResponse(0, "Register Success", createdUser)
		ctx.JSON(http.StatusCreated, response)
	}
}
