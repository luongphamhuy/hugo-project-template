# Quy trình Triển khai Hugo Site

## 1. Chuẩn bị
- Đảm bảo tất cả thay đổi đã được commit và push lên GitHub
- Kiểm tra cấu hình trong `config.toml`

## 2. Build Hugo Site
- Chạy lệnh: `hugo --minify`
- Kiểm tra thư mục `public/` đã được tạo

## 3. Cấu hình Google Cloud Storage
- Tạo một bucket mới: `gsutil mb gs://[TEN_BUCKET]`
- Cấu hình quyền truy cập công khai:
  
gsutil iam ch allUsers:objectViewer gs://[TEN_BUCKET]


## 4. Upload lên Google Cloud Storage
- Sử dụng lệnh:

gsutil -m rsync -R public/ gs://[TEN_BUCKET]


## 5. Cấu hình Cloud CDN (tùy chọn)
- Tạo một Cloud CDN endpoint cho bucket
- Cấu hình DNS để trỏ đến CDN endpoint

## 6. Cấu hình Custom Domain (nếu cần)
- Thêm bản ghi CNAME trong DNS provider
- Cấu hình SSL/TLS cho domain

## 7. Kiểm tra Triển khai
- Truy cập website thông qua domain đã cấu hình
- Kiểm tra các trang và chức năng

## 8. Monitoring và Logging
- Thiết lập Google Cloud Monitoring
- Cấu hình alerts cho các sự cố quan trọng

## 9. Cập nhật và Bảo trì
- Thiết lập quy trình cập nhật nội dung định kỳ
- Lên kế hoạch bảo trì và nâng cấp hệ thống

Tuân theo quy trình này sẽ giúp đảm bảo việc triển khai Hugo site của bạn diễn ra suôn sẻ và an toàn.
