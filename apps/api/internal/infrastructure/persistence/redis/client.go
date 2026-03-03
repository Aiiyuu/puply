package redis

import (
	"os"

	"github.com/redis/go-redis/v9"
)

func NewClient() *redis.Client {
	addr := os.Getenv("REDIS_URL")

	return redis.NewClient(&redis.Options{
		Addr:     addr,
		Password: "",
		DB:       0,
	})
}
