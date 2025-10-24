# Website Bán Máy Tính - Backend

Backend xây dựng bằng Node.js/Express cho nền tảng thương mại điện tử chuyên bán máy tính và laptop.

## 🛠 Công Nghệ Sử Dụng

- **Môi Trường Runtime:** Node.js
- **Framework:** Express.js
- **Cơ Sở Dữ Liệu:** MySQL
- **Xác Thực:** JWT (JSON Web Tokens)
- **Bảo Mật Mật Khẩu:** bcrypt
- **Bảo Mật API:** CORS enabled

## 🚀 Tính Năng

### Quản Lý Sản Phẩm
- Xem tất cả sản phẩm và biến thể
- Tìm kiếm sản phẩm
- Phân loại sản phẩm (Gaming, Văn Phòng, Workstation, MacBook)
- Sản phẩm nổi bật
- Hỗ trợ nhiều biến thể sản phẩm

### Quản Lý Người Dùng
- Đăng ký và xác thực người dùng
- Phân quyền người dùng (Admin/User)
- Xác thực bảo mật bằng JWT
- Quản lý thông tin người dùng

### Hệ Thống Đặt Hàng
- Tạo đơn hàng mới
- Theo dõi trạng thái đơn hàng
- Xem lịch sử đơn hàng theo người dùng

### Quản Lý Thương Hiệu
- Đầy đủ các thao tác CRUD
- Hỗ trợ hình ảnh thương hiệu
- Lọc sản phẩm theo thương hiệu

## 📋 Yêu Cầu Hệ Thống

- Node.js
- MySQL Server
- npm hoặc yarn

## ⚙️ Cấu Hình

1. Tạo file `.env` trong thư mục `src` với các biến sau:
```env
PORT=3000
JWT_SECRET=your_jwt_secret_key
JWT_EXPIRATION=24h
```

2. Cấu hình Database (trong `src/config/db.js`):
```javascript
{
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: '',
    database: 'Laptop_BuyOnline'
}
```

## 🔧 Cài Đặt

1. Clone repository:
```bash
git clone https://github.com/dinhgiang1-git/Web_BE_Selling-Computer.git
```

2. Cài đặt các dependencies:
```bash
cd Web_BE_Selling-Computer
npm install
```

3. Thiết lập cơ sở dữ liệu MySQL:
- Tạo database tên `Laptop_BuyOnline`
- Import schema database (nếu có)

4. Khởi động server:
```bash
npm start
```

## 🔌 Các Endpoint API

### Sản Phẩm
- `GET /api/products/get-all` - Lấy tất cả sản phẩm
- `GET /api/products/get-by-id/:id` - Lấy sản phẩm theo ID
- `GET /api/products/search` - Tìm kiếm sản phẩm

### Người Dùng
- `POST /api/users/register` - Đăng ký người dùng mới
- `POST /api/users/login` - Đăng nhập
- `GET /api/users/get-by-id/:id` - Lấy thông tin người dùng
- `PATCH /api/users/update/:id` - Cập nhật thông tin người dùng

### Đơn Hàng
- `POST /api/orders/create` - Tạo đơn hàng mới
- `GET /api/orders/get-by-id-user` - Lấy đơn hàng của người dùng

### Thương Hiệu
- `GET /api/brands/get-all` - Lấy tất cả thương hiệu
- `GET /api/brands/get-by-id/:id` - Lấy thương hiệu theo ID
- `POST /api/brands/create` - Tạo thương hiệu mới
- `PATCH /api/brands/update/:id` - Cập nhật thương hiệu
- `DELETE /api/brands/delete/:id` - Xóa thương hiệu

## 🔐 Bảo Mật

- Mã hóa mật khẩu sử dụng bcrypt
- Xác thực token JWT
- Kiểm soát quyền truy cập theo vai trò
- Bật CORS (cấu hình cho localhost:5173)

## 🛡️ Middleware

- Middleware xác thực JWT
- Middleware kiểm soát quyền truy cập
- Middleware xử lý lỗi

## 📁 Cấu Trúc Dự Án

```
src/
├── app/
│   └── controllers/
├── config/
├── constants/
├── middlewares/
├── public/
├── routes/
└── index.js
```

## 👥 Tác Giả

- [@dinhgiang1-git](https://github.com/dinhgiang1-git)

## 📅 Cập Nhật Lần Cuối

2025-10-11
