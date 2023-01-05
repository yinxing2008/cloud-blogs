package helper

type Response struct {
	Code int         `json:"code"`
	Msg  string      `json:"msg"`
	Data interface{} `json:"data"`
}

type EmptyObject struct {
}

func SuccessResponse(code int, msg string, data interface{}) Response {
	return Response{
		Code: code,
		Msg:  msg,
		Data: data,
	}
}

func ErrorsResponse(code int, err string, data interface{}) Response {
	return Response{
		Code: code,
		Msg:  err,
		Data: data,
	}
}
