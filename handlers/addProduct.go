package handlers

import (
	"log"
	"net/http"

	"main.go/db"
)

func AddProductHandler(w http.ResponseWriter, r *http.Request) {
	productName := "test_productName1"
	brandName := "test_brandName1"
	imagePath := "test_imagePath1"

	db.Init()

	var err error

	_, err = db.DB.Exec("INSERT INTO brands (name) VALUES ($1)", brandName)
	if err != nil {
		log.Println("Error inserting brand:", err)
		http.Error(w, "Failed to insert brand information", http.StatusInternalServerError)
		return
	}

	var brandID int64
	err = db.DB.QueryRow("SELECT brand_id FROM brands WHERE name = $1", brandName).Scan(&brandID)
	if err != nil {
		http.Error(w, "Failed to get brand ID", http.StatusInternalServerError)
		return
	}

	_, err = db.DB.Exec("INSERT INTO products (name, brand_id) VALUES ($1, $2)", productName, brandID)
	if err != nil {
		http.Error(w, "Failed to insert product information", http.StatusInternalServerError)
		return
	}

	var productID int64
	err = db.DB.QueryRow("SELECT product_id FROM products WHERE name = $1", productName).Scan(&productID)
	if err != nil {
		http.Error(w, "Failed to get product ID", http.StatusInternalServerError)
		return
	}

	_, err = db.DB.Exec("INSERT INTO images (image_path, product_id) VALUES ($1, $2)", imagePath, productID)
	if err != nil {
		http.Error(w, "Failed to insert image information", http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusCreated)
	w.Write([]byte("Product added successfully"))
}
