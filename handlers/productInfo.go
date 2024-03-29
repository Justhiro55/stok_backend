package handlers

import (
	"database/sql"
	"encoding/json"
	"log"
	"net/http"
	"strconv"

	"main.go/db"
)

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

	row := db.DB.QueryRow("SELECT product_id, name, brand_id FROM products WHERE product_id = $1", productID)

	var productName string
	var brandID int64
	err = row.Scan(&productID, &productName, &brandID)
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
