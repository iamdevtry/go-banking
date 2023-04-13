package gapi

import (
	"fmt"

	db "github.com/iamdevtry/go-bank/db/sqlc"
	"github.com/iamdevtry/go-bank/pb"
	"github.com/iamdevtry/go-bank/token"
	"github.com/iamdevtry/go-bank/util"
)

// Server is the main struct for the gRPC server
type Server struct {
	pb.UnimplementedGoBankServer
	config     util.Config
	store      db.Store
	tokenMaker token.Maker
}

// NewServer creates a new gRPC server.
func NewServer(config util.Config, store db.Store) (*Server, error) {
	tokenMaker, err := token.NewPasetoMaker(config.TokenSymmetricKey)
	if err != nil {
		return nil, fmt.Errorf("cannot create token maker: %w", err)
	}
	server := &Server{
		config:     config,
		store:      store,
		tokenMaker: tokenMaker,
	}

	return server, nil
}
