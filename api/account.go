package api

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type createAccountParams struct {
	Owner    string `json:"owner" binding:"required"`
	Currency string `json:"currency" binding:"required, oneof=USD EUR"`
}

func (server *Server) createAccount(ctx *gin.Context) {
	var arg createAccountParams
	if err := ctx.ShouldBindJSON(&arg); err != nil {
		ctx.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}
	account, err := server.store.CreateAccount(ctx, arg)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}
	ctx.JSON(http.StatusOK, account)
}
