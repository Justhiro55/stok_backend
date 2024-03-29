package main

import (
	"database/sql"
	"encoding/json"
	"log"
	"net/http"
	"os"
	"strconv"

	_ "github.com/lib/pq"
	"github.com/rs/cors"
)

var DB *sql.DB

func Init() {
	var err error
	DB, err = sql.Open("postgres", "postgres://postgres:passwd@localhost:port/postgres?sslmode=disable")
	if err != nil {
		log.Fatal(err)
	}
	if err = DB.Ping(); err != nil {
		log.Fatal(err)
	}
}

func ProductInfoHandler(w http.ResponseWriter, r *http.Request) {
	productIDStr := r.URL.Query().Get("id")
	if productIDStr == "" {
		http.Error(w, "Product ID is required", http.StatusBadRequest)
		return
	}

	var productID int64
	var err error
	productID, err = strconv.ParseInt(productIDStr, 10, 64)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	var productName string
	var brandID int64

	err = DB.QueryRow("SELECT product_id, name, brand_id FROM products WHERE product_id = $1", productID).Scan(&productID, &productName, &brandID)
	if err != nil {
		if err == sql.ErrNoRows {
			http.Error(w, "Product not found", http.StatusNotFound)
			return
		}
		log.Printf("Database error: %s", err)
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(map[string]interface{}{
		"id":       productID,
		"name":     productName,
		"brand_id": brandID,
	})
}

func main() {
	log.SetOutput(os.Stdout)
	Init()

	corsHandler := cors.New(cors.Options{
		AllowedOrigins:   []string{"http://localhost:3000"},
		AllowedMethods:   []string{"GET", "POST", "PUT"},
		AllowCredentials: true,
	})

	http.Handle("/api/products", corsHandler.Handler(http.HandlerFunc(ProductInfoHandler)))

	log.Println("Server starting on http://localhost:8080")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal("ListenAndServe:", err)
	}
}
