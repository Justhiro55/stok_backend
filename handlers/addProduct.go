package handlers

import (
	"encoding/json"
	"log"
	"net/http"

	"main.go/db"
)

type ProductData struct {
	ProductName string `json:"product_name"`
	BrandName   string `json:"brand_name"`
	ImagePath   string `json:"image_path"`
}

func AddProductHandler(w http.ResponseWriter, r *http.Request) {
	var data ProductData

	err := json.NewDecoder(r.Body).Decode(&data)
	if err != nil {
		log.Println("Error decoding JSON:", err)
		http.Error(w, "Failed to parse JSON", http.StatusBadRequest)
		return
	}

	db.Init()

	tx, err := db.DB.Begin()
	if err != nil {
		log.Println("Error starting transaction:", err)
		http.Error(w, "Internal server error", http.StatusInternalServerError)
		return
	}

	_, err = tx.Exec("INSERT INTO brands (name) VALUES ($1)", data.BrandName)
	if err != nil {
		tx.Rollback()
		log.Println("Error inserting brand:", err)
		http.Error(w, "Failed to insert brand information", http.StatusInternalServerError)
		return
	}

	var brandID int64
	err = tx.QueryRow("SELECT brand_id FROM brands WHERE name = $1", data.BrandName).Scan(&brandID)
	if err != nil {
		tx.Rollback()
		log.Println("Error getting brand ID:", err)
		http.Error(w, "Failed to get brand ID", http.StatusInternalServerError)
		return
	}

	_, err = tx.Exec("INSERT INTO products (name, brand_id) VALUES ($1, $2)", data.ProductName, brandID)
	if err != nil {
		tx.Rollback()
		log.Println("Error inserting product:", err)
		http.Error(w, "Failed to insert product information", http.StatusInternalServerError)
		return
	}

	var productID int64
	err = tx.QueryRow("SELECT product_id FROM products WHERE name = $1", data.ProductName).Scan(&productID)
	if err != nil {
		tx.Rollback()
		log.Println("Error getting product ID:", err)
		http.Error(w, "Failed to get product ID", http.StatusInternalServerError)
		return
	}

	_, err = tx.Exec("INSERT INTO images (image_path, product_id) VALUES ($1, $2)", data.ImagePath, productID)
	if err != nil {
		tx.Rollback()
		log.Println("Error inserting image:", err)
		http.Error(w, "Failed to insert image information", http.StatusInternalServerError)
		return
	}

	err = tx.Commit()
	if err != nil {
		log.Println("Error committing transaction:", err)
		http.Error(w, "Internal server error", http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusCreated)
	w.Write([]byte("Product added successfully"))
}
