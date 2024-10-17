# Hướng dẫn Thiết lập Project trên Google Cloud Platform (GCP)

## Giới thiệu
Hướng dẫn này sẽ giúp bạn thiết lập một project GCP để host website Hugo. Quá trình này bao gồm việc tạo project, kích hoạt các API cần thiết, cấu hình lưu trữ và bảo mật.

## 1. Tạo Project mới trên GCP
1. Truy cập [Google Cloud Console](https://console.cloud.google.com/).
2. Click vào menu dropdown ở góc trên cùng bên trái và chọn "New Project".
3. Đặt tên cho project (ví dụ: "my-hugo-website") và chọn tổ chức (nếu có).
4. Click "Create".

## 2. Kích hoạt các API cần thiết
1. Trong GCP Console, đi tới "APIs & Services" > "Library".
2. Tìm và kích hoạt các API sau:
   - Cloud Build API
   - Cloud Storage API
   - Cloud DNS API (nếu sử dụng Google Cloud DNS)

Lưu ý: Việc kích hoạt API có thể mất vài phút.

## 3. Tạo Service Account
1. Đi tới "IAM & Admin" > "Service Accounts".
2. Click "Create Service Account".
3. Đặt tên (ví dụ: "hugo-deployer") và mô tả cho service account.
4. Gán các vai trò sau:
   - Cloud Build Service Account
   - Storage Admin
   - Storage Object Creator
   - Storage Object Viewer
5. Click "Create" và tải xuống key JSON cho service account.

Quan trọng: Giữ file key JSON an toàn và không chia sẻ nó công khai.

## 4. Thiết lập Cloud Storage
1. Đi tới "Cloud Storage" > "Browser".
2. Click "Create Bucket".
3. Đặt tên cho bucket (ví dụ: "my-hugo-website-bucket").
4. Chọn Region hoặc Multi-region tùy theo nhu cầu.
5. Trong "Choose how to control access to objects", chọn "Fine-grained".
6. Click "Create".
7. Sau khi tạo, vào tab "Permissions" của bucket.
8. Click "Add" và thêm "allUsers" với vai trò "Storage Object Viewer" để cho phép truy cập công khai.

## 5. Cấu hình Cloud DNS (nếu sử dụng custom domain)
1. Đi tới "Network Services" > "Cloud DNS".
2. Click "Create Zone".
3. Đặt tên cho zone và nhập tên miền của bạn.
4. Click "Create".
5. Thêm các bản ghi DNS cần thiết (A, CNAME) để trỏ đến Cloud Storage bucket.

## 6. Thiết lập Billing
1. Đi tới "Billing" trong menu chính.
2. Liên kết project với một tài khoản thanh toán hoặc tạo mới.

Lưu ý: Một số dịch vụ có thể phát sinh chi phí. Kiểm tra bảng giá GCP để biết chi tiết.

## 7. Cấu hình Quyền truy cập
1. Đi tới "IAM & Admin" > "IAM".
2. Thêm các thành viên dự án và gán quyền phù hợp (ví dụ: Editor, Viewer).

## 8. Thiết lập Môi trường Phát triển
1. Cài đặt [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) trên máy local.
2. Mở terminal và chạy `gcloud init` để cấu hình SDK với project của bạn.
3. Xác thực và chọn project vừa tạo khi được nhắc.

## Kiểm tra và Xác minh
Sau khi hoàn thành các bước trên, hãy kiểm tra:
1. APIs & Services để đảm bảo tất cả API cần thiết đã được kích hoạt.
2. IAM để xác nhận service account có đủ quyền.
3. Cloud Storage để đảm bảo bucket đã được cấu hình đúng.

## Kết luận
Bạn đã hoàn tất việc thiết lập project GCP cho website Hugo. Project này đã sẵn sàng để tích hợp với quy trình CI/CD và triển khai website của bạn.

## Tài nguyên bổ sung
- [Tài liệu chính thức của Google Cloud](https://cloud.google.com/docs)
- [Hướng dẫn sử dụng Hugo với GCP](https://gohugo.io/hosting-and-deployment/hosting-on-google-cloud-storage/)
- [Quản lý chi phí GCP](https://cloud.google.com/cost-management)

Nếu bạn gặp bất kỳ vấn đề nào trong quá trình thiết lập, hãy tham khảo tài liệu chính thức của GCP hoặc liên hệ với support của Google Cloud.


