package main

import (
	"log"
	"puply/api/internal/interfaces/http"
)

func main() {
	r := http.NewRouter()

	port := ":8080"

	log.Printf("🚀 Puply API starting on port http://localhost%v", port)

	if err := r.Run(":8080"); err != nil {
		log.Fatalf("Could not run server: %v", err)
	}
}
