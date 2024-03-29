package main

import (
	"log"
	"net/http"
	"os"

	"main.go/db"
	"main.go/handlers"

	_ "github.com/lib/pq"
	"github.com/rs/cors"
)

func main() {
	log.SetOutput(os.Stdout)
	db.Init()

	corsHandler := cors.New(cors.Options{
		AllowedOrigins:   []string{"http://localhost:3000"},
		AllowedMethods:   []string{"GET", "POST", "PUT"},
		AllowCredentials: true,
	})

	http.Handle("/api/products", corsHandler.Handler(http.HandlerFunc(handlers.ProductInfoHandler)))

	log.Println("Server starting on http://localhost:8080")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal("ListenAndServe:", err)
	}
}
