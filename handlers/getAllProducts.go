package handlers

import (
	"encoding/json"
	"log"
	"net/http"

	"main.go/db"
)

type ProductInfo struct {
	ProductName string   `json:"product_name"`
	BrandName   string   `json:"brand_name"`
	ImagePaths  []string `json:"image_paths"`
}

func GetAllProductsHandler(w http.ResponseWriter, r *http.Request) {
	query := `
		SELECT products.name, brands.name, images.image_path
		FROM products
		JOIN brands ON products.brand_id = brands.brand_id
		LEFT JOIN images ON products.product_id = images.product_id
		ORDER BY products.product_id, images.image_path
	
	`
	rows, err := db.DB.Query(query)
	if err != nil {
		log.Printf("Database error: %s", err)
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var products []ProductInfo
	var currentProduct *ProductInfo
	var lastProductName string

	for rows.Next() {
		var productName, brandName, imagePath string
		err := rows.Scan(&productName, &brandName, &imagePath)
		if err != nil {
			log.Printf("Error scanning row: %s", err)
			continue
		}

		if lastProductName != productName {
			if currentProduct != nil {
				products = append(products, *currentProduct)
			}
			currentProduct = &ProductInfo{
				ProductName: productName,
				BrandName:   brandName,
				ImagePaths:  []string{},
			}
			lastProductName = productName
		}

		if imagePath != "" && currentProduct != nil {
			currentProduct.ImagePaths = append(currentProduct.ImagePaths, imagePath)
		}
	}
	if currentProduct != nil {
		products = append(products, *currentProduct)
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(products)
}
