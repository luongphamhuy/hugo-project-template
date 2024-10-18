# Hướng dẫn Thiết lập Project trên Google Cloud Platform (GCP) cho Website Hugo

## Giới thiệu
Hướng dẫn này sẽ giúp bạn thiết lập một project GCP để host website Hugo. Quá trình này bao gồm việc tạo project, kích hoạt các API cần thiết, cấu hình lưu trữ, bảo mật, và tối ưu hiệu suất.

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
   - Compute Engine API (cho Load Balancer và SSL)
   - Cloud Monitoring API
   - Cloud Logging API

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
   - Compute Network Admin (cho Load Balancer)
   - Cloud CDN Editor (nếu sử dụng CDN)
5. Click "Create" và tải xuống key JSON cho service account.

Quan trọng: Giữ file key JSON an toàn và không chia sẻ nó công khai.

## 4. Thiết lập Cloud Storage
1. Đi tới "Cloud Storage" > "Browser".
2. Click "Create Bucket".
3. Đặt tên cho bucket (ví dụ: "my-hugo-website-bucket").
4. Chọn Region hoặc Multi-region tùy theo nhu cầu.
5. Trong "Choose how to control access to objects", chọn "Fine-grained".
6. Click "Create".

### 4a. Cấu hình Quyền truy cập Bucket
1. Sau khi tạo bucket, vào tab "Permissions" của bucket.
2. Click "Add" và thêm "allUsers" với vai trò "Storage Object Viewer" để cho phép truy cập công khai.
3. Thêm service account đã tạo ở bước 3 với vai trò "Storage Object Admin".

### 4b. Cấu hình Static Website Hosting
1. Trong Cloud Storage, chọn bucket của bạn.
2. Đi tới tab "Website configuration".
3. Bật tính năng "Enable website configuration".
4. Đặt "Main page" là "index.html".
5. Đặt "Not found page" là "404.html" (nếu có).
6. Lưu cấu hình.

### 4c. Cấu hình CORS (nếu cần)
CORS (Cross-Origin Resource Sharing) là một cơ chế bảo mật cho phép hoặc hạn chế các tài nguyên web được yêu cầu từ một domain khác với domain đang phục vụ trang web. Cấu hình CORS trong Cloud Storage có những tác dụng sau:

Cho phép truy cập từ các domain khác.
Tăng tính linh hoạt cho ứng dụng.
Hỗ trợ cho API và Microservices.
Kiểm soát bảo mật.
Để cấu hình CORS:

Trong Cloud Storage, chọn bucket của bạn.
Đi tới tab "CORS configuration".
Thêm cấu hình CORS phù hợp với nhu cầu của bạn, ví dụ:
[
  {
    "origin": ["*"],
    "method": ["GET", "HEAD", "OPTIONS"],
    "responseHeader": ["Content-Type"],
    "maxAgeSeconds": 3600
  }
]
Lưu cấu hình.
Giải thích cấu hình mẫu:

"origin": ["*"]: Cho phép tất cả các domain truy cập.
"method": ["GET", "HEAD", "OPTIONS"]: Chỉ cho phép các phương thức HTTP là GET, HEAD, và OPTIONS.
"responseHeader": ["Content-Type"]: Cho phép client đọc header Content-Type từ response.
"maxAgeSeconds": 3600: Kết quả của preflight request có thể được cache trong 1 giờ.
Lưu ý: Cấu hình này khá mở. Trong môi trường sản xuất, bạn nên cân nhắc giới hạn origin chỉ cho các domain cụ thể mà bạn muốn cho phép.



## 5. Cấu hình Cloud DNS (nếu sử dụng custom domain)
1. Đi tới "Network Services" > "Cloud DNS".
2. Click "Create Zone".
3. Đặt tên cho zone và nhập tên miền của bạn.
4. Click "Create".
5. Thêm các bản ghi DNS cần thiết (A, CNAME) để trỏ đến Cloud Storage bucket hoặc Load Balancer IP (nếu sử dụng).

## 6. Thiết lập Billing
1. Đi tới "Billing" trong menu chính.
2. Liên kết project với một tài khoản thanh toán hoặc tạo mới.
3. Xem xét thiết lập cảnh báo ngân sách để kiểm soát chi phí.

Lưu ý: Một số dịch vụ có thể phát sinh chi phí. Kiểm tra bảng giá GCP để biết chi tiết.

## 7. Cấu hình Quyền truy cập
1. Đi tới "IAM & Admin" > "IAM".
2. Thêm các thành viên dự án và gán quyền phù hợp (ví dụ: Editor, Viewer).
3. Xem xét áp dụng nguyên tắc least privilege để tăng cường bảo mật.

## 8. Thiết lập Môi trường Phát triển
1. Cài đặt [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) trên máy local.
2. Mở terminal và chạy `gcloud init` để cấu hình SDK với project của bạn.
3. Xác thực và chọn project vừa tạo khi được nhắc.

## 9. Thiết lập Cloud Build (CI/CD)
1. Đi tới "Cloud Build" trong GCP Console.
2. Click "Create Trigger".
3. Chọn repository source (ví dụ: GitHub, Bitbucket).
4. Cấu hình trigger (ví dụ: push to main branch).
5. Tạo file cloudbuild.yaml trong repository của bạn với các bước build và deploy.
6. Lưu và kích hoạt trigger.

Ví dụ về file cloudbuild.yaml cơ bản:
```yaml
steps:
- name: 'gcr.io/cloud-builders/hugo'
  args: ['--minify']
- name: 'gcr.io/cloud-builders/gsutil'
  args: ['-m', 'rsync', '-r', '-c', '-d', 'public/', 'gs://your-bucket-name/']
```

## 10. Cấu hình SSL (cho custom domain)
1. Đi tới "Load Balancing" trong GCP Console.
2. Tạo một HTTP(S) Load Balancer.
3. Cấu hình backend bucket trỏ đến Cloud Storage bucket của bạn.
4. Cấu hình frontend với IP và port.
5. Thêm SSL certificate (có thể sử dụng Google-managed certificates).
6. Cập nhật DNS records để trỏ đến IP của Load Balancer.

## 11. Thiết lập Monitoring và Logging
1. Đi tới "Monitoring" trong GCP Console.
2. Tạo dashboard để theo dõi metrics quan trọng (ví dụ: lưu lượng truy cập, latency).
3. Thiết lập các cảnh báo cho các sự kiện quan trọng:
   - Lưu lượng truy cập cao bất thường
   - Lỗi 4xx hoặc 5xx
   - Latency vượt ngưỡng
4. Trong "Logging", cấu hình log filters để theo dõi các hoạt động quan trọng:
   - Truy cập vào bucket
   - Hoạt động của Cloud Build
   - Thay đổi cấu hình

## 12. Tối ưu hiệu suất
1. Bật Cloud CDN cho bucket của bạn:
   - Đi tới "Cloud CDN" trong GCP Console.
   - Tạo một cấu hình CDN mới và liên kết với bucket của bạn.
2. Cấu hình caching policy phù hợp.
3. Xem xét sử dụng Cloud Armor để bảo vệ khỏi DDoS và các cuộc tấn công web.

## Kiểm tra và Xác minh
Sau khi hoàn thành các bước trên, hãy kiểm tra:
1. APIs & Services để đảm bảo tất cả API cần thiết đã được kích hoạt.
2. IAM để xác nhận service account và user permissions đã được cấu hình đúng.
3. Cloud Storage để đảm bảo bucket đã được cấu hình đúng cho static website hosting.
4. Cloud Build để đảm bảo trigger hoạt động chính xác.
5. Load Balancer và SSL (nếu sử dụng) để đảm bảo HTTPS hoạt động.
6. Cloud CDN để xác nhận caching đang hoạt động.
7. Monitoring để đảm bảo các metrics đang được thu thập và cảnh báo đã được thiết lập.

## Kết luận
Bạn đã hoàn tất việc thiết lập một project GCP toàn diện cho website Hugo. Project này đã sẵn sàng để tích hợp với quy trình CI/CD, có khả năng mở rộng, được bảo mật và tối ưu hiệu suất.

## Tài nguyên bổ sung
- [Tài liệu chính thức của Google Cloud](https://cloud.google.com/docs)
- [Hướng dẫn sử dụng Hugo với GCP](https://gohugo.io/hosting-and-deployment/hosting-on-google-cloud-storage/)
- [Quản lý chi phí GCP](https://cloud.google.com/cost-management)
- [Best practices for Cloud Storage](https://cloud.google.com/storage/docs/best-practices)
- [Securing Cloud Storage buckets](https://cloud.google.com/storage/docs/best-practices#security)

Nếu bạn gặp bất kỳ vấn đề nào trong quá trình thiết lập, hãy tham khảo tài liệu chính thức của GCP hoặc liên hệ với support của Google Cloud.