package http

import (
	"github.com/gin-gonic/gin"
)

func NewRouter() *gin.Engine {
	r := gin.Default()

	_ = r.SetTrustedProxies(nil)

	return r
}
