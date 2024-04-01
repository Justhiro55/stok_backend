#!/bin/bash

#==============================GetAllProductsHandler Tester=============================#
echo "---------------------------------------"
echo "Starting tests for GetAllProductsHandler..."
echo "---------------------------------------"

# Test GetAllProductsHandler for successful response
echo "[GetAllProductsHandler] Testing for successful response..."
full_response=$(curl -s -w "\n%{http_code}" "http://localhost:8080/api/getAllProduct")

# Split the response into body and status code
response_body=$(echo "$full_response" | sed '$d')  # This removes the last line (status code)
status_code=$(echo "$full_response" | tail -n 1)

if [[ "$status_code" == "200" ]]; then
    echo "✅ Test successful: Expected 200, Actual $status_code"
else
    echo "❌ Test failed: Expected 200, Actual $status_code"
fi

echo "Status Code: $status_code"
echo "Response body:"
echo "$response_body"

echo "\n"
