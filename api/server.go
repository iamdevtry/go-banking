package api

import (
	"github.com/gin-gonic/gin"
	db "github.com/iamdevtry/go-bank/db/sqlc"
)

// Server is the main struct for the API server
type Server struct {
	store  *db.Store
	router *gin.Engine
}

// NewServer creates a new HTTP server and setup the routing
func NewServer(store *db.Store) *Server {
	server := &Server{store: store}
	router := gin.Default()

	router.POST("/accounts", server.createAccount)

	server.router = router
	return server
}

func errorResponse(err error) gin.H {
	return gin.H{"error": err.Error()}
}
