package token

import "time"

// Maker is the interface for managing token
type Maker interface {
	// CreateToken creates a token for the given username with the given duration
	CreateToken(username string, duration time.Duration) (string, error)

	// VerifyToken verifies the given token and returns the payload
	VerifyToken(token string) (*Payload, error)
}
