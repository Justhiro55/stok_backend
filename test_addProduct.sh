#!/bin/bash

#==============================AddProductHandler Tester=============================#
echo "---------------------------------------"
echo "Starting tests for AddProductHandler..."
echo "---------------------------------------"

# Function to check if product was added successfully using GetAllProductsHandler
check_product_added() {
    echo "Checking if product was added by querying all products..."
    response=$(curl -s "http://localhost:8080/api/getAllProduct")
    echo "$response" | json_pp
}

# Test AddProductHandler with a single image path
echo "[AddProductHandler] Testing with a single image path..."
response=$(curl -s -w "%{http_code}" -X POST "http://localhost:8080/api/addProduct" \
     -H "Content-Type: application/json" \
     -d '{"product_name":"Test Product Single", "brand_name":"Test Brand", "image_path":["path/to/single/image"]}')
status_code=$(echo "$response" | grep -o '[0-9]\{3\}$')

if [[ "$status_code" == "201" ]]; then
    echo "✅ Test successful: Expected 201, Actual $status_code"
    check_product_added
else
    echo "❌ Test failed: Expected 201, Actual $status_code"
fi

echo "\n"

# Test AddProductHandler with multiple image paths
echo "[AddProductHandler] Testing with multiple image paths..."
response=$(curl -s -w "%{http_code}" -X POST "http://localhost:8080/api/addProduct" \
     -H "Content-Type: application/json" \
     -d '{"product_name":"Test Product Multiple", "brand_name":"Test Brand", "image_path":["path/to/first/image", "path/to/second/image"]}')
status_code=$(echo "$response" | grep -o '[0-9]\{3\}$')

if [[ "$status_code" == "201" ]]; then
    echo "✅ Test successful: Expected 201, Actual $status_code"
    check_product_added
else
    echo "❌ Test failed: Expected 201, Actual $status_code"
fi

echo "\n"
echo "---------------------------------------"
echo "Tests completed."
echo "---------------------------------------"
