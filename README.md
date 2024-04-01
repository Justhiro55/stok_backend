# stok_backend

## テスト確認手順

### 1. プロジェクトのセットアップ

リポジトリをクローンしてディレクトリに移動します。

```bash
git clone git@github.com:Justhiro55/stok_backend.git && cd stok_backend
```

### 2. データベースのセットアップ
```bash
psql -U your_username your_database_name < data.sql
```

db.go の 14 行目を適切な接続情報を設定します．
```bash
db, err = sql.Open("postgres", "user=your_username dbname=your_database_name password=your_password host=localhost port=5432 sslmode=disable")
```

### 3. Goプログラムの実行
```bash
go run .
```

### 4. エラーハンドリングのテスト
```bash
sh test_error.sh
```

### 5. すべての製品が取得できるかのテスト
```bash
sh test_getAllProducts.sh
```

### 6. 製品が正常に追加されるかのテスト
```bash
sh test_addProduct.sh
```
