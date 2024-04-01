package handlers

import (
	"database/sql"
	"encoding/json"
	"log"
	"net/http"
	"strconv"

	"main.go/db"
)

func GetProductHandler(w http.ResponseWriter, r *http.Request) {
	productIDStr := r.URL.Query().Get("id")
	if productIDStr == "" {
		http.Error(w, "Product ID is required", http.StatusBadRequest)
		return
	}

	productID, err := strconv.ParseInt(productIDStr, 10, 64)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	row := db.DB.QueryRow(`
		SELECT products.name, brands.name
		FROM products
		JOIN brands ON products.brand_id = brands.brand_id
		WHERE products.product_id = $1`, productID)

	var productName, brandName string
	err = row.Scan(&productName, &brandName)
	if err != nil {
		if err == sql.ErrNoRows {
			http.Error(w, "Product not found", http.StatusNotFound)
			return
		}
		log.Printf("Database error: %s", err)
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	rows, err := db.DB.Query("SELECT image_path FROM images WHERE product_id = $1", productID)
	if err != nil {
		log.Printf("Database error: %s", err)
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	imagePaths := []string{}
	for rows.Next() {
		var imagePath string
		if err := rows.Scan(&imagePath); err != nil {
			log.Printf("Database error: %s", err)
			continue
		}
		imagePaths = append(imagePaths, imagePath)
	}

	json.NewEncoder(w).Encode(map[string]interface{}{
		"productName": productName,
		"brandName":   brandName,
		"images":      imagePaths,
	})
}
