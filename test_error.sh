#!/bin/bash

#==============================AddProductHandler Tester=============================#
echo "---------------------------------------"
echo "Starting tests for AddProductHandler..."
echo "---------------------------------------"

# 空の項目を含むデータでAddProductHandlerをテストする
echo "[AddProductHandler] Testing with empty fields..."
response=$(curl -s -w "%{http_code}" -X POST "http://localhost:8080/api/addProduct" -d '{"product_name":"", "brand_name":"Test Brand", "image_path":["path1","path2"]}' -H "Content-Type: application/json")
status_code=$(echo $response | grep -o '[0-9]\{3\}$')
if [[ "$status_code" =~ ^4[0-9]{2}$ || "$status_code" =~ ^5[0-9]{2}$ ]]; then
    echo "✅ Test successful: Expected , Actual $status_code"
else
    echo "❌ Test failed: Expected , Actual $status_code"
fi

# 重複を含むデータでAddProductHandlerをテストする
echo "[AddProductHandler] Testing with duplicate data..."
response=$(curl -s -w "%{http_code}" -X POST "http://localhost:8080/api/addProduct" -d '{"product_name":"KENZO '\''TIGER CREST'\'' POLO SHIRT", "brand_name":"Test Brand", "image_path":["https://stok.store/cdn/shop/files/20220304040105603_E52---kenzo---FA65PO0014PU01B_4_M1.jpg"]}' -H "Content-Type: application/json")
status_code=$(echo $response | grep -o '[0-9]\{3\}$')
if [[ "$status_code" == "500" ]]; then
    echo "✅ Test successful: Expected 500, Actual $status_code"
else
    echo "❌ Test failed: Expected 500, Actual $status_code"
fi

echo "\n"

echo "---------------------------------------"
echo "Starting tests for ProductInfoHandler..."
echo "---------------------------------------"

# 無効なIDをテスト
echo "[ProductInfoHandler] Testing with invalid ID..."
response=$(curl -s -w "%{http_code}" "http://localhost:8080/api/productInfo?id=invalid_id")
status_code=$(echo $response | grep -o '[0-9]\{3\}$')
if [[ "$status_code" =~ ^4[0-9]{2}$ || "$status_code" =~ ^5[0-9]{2}$ ]]; then
    echo "✅ Test successful: Expected 400, Actual $status_code"
else
    echo "❌ Test failed: Expected 400, Actual $status_code"
fi

# IDが空のテスト
echo "[ProductInfoHandler] Testing with no ID..."
response=$(curl -s -w "%{http_code}" "http://localhost:8080/api/productInfo")
status_code=$(echo $response | grep -o '[0-9]\{3\}$')
if [[ "$status_code" =~ ^4[0-9]{2}$ || "$status_code" =~ ^5[0-9]{2}$ ]]; then
    echo "✅ Test successful: Expected 400, Actual $status_code"
else
    echo "❌ Test failed: Expected 400, Actual $status_code"
fi

# 存在しないIDのテスト
echo "[ProductInfoHandler] Testing with non-existent product ID..."
response=$(curl -s -w "%{http_code}" "http://localhost:8080/api/productInfo?id=999999")
status_code=$(echo $response | grep -o '[0-9]\{3\}$')
if [[ "$status_code" =~ ^4[0-9]{2}$ || "$status_code" =~ ^5[0-9]{2}$ ]]; then
    echo "✅ Test successful: Expected 404, Actual $status_code"
else
    echo "❌ Test failed: Expected 404, Actual $status_code"
fi

echo "\n"

echo "---------------------------------------"
echo "Tests completed."
echo "---------------------------------------"
