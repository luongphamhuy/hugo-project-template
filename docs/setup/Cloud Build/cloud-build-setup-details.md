# Hướng dẫn Chi tiết Cấu hình và Sử dụng Cloud Build cho Dự án Hugo

## 1. Tạo và Cấu hình file cloudbuild.yaml

Tạo file `cloudbuild.yaml` trong thư mục gốc của dự án với nội dung sau:

```yaml
steps:
# Bước 1: Cài đặt Hugo
- name: 'gcr.io/cloud-builders/wget'
  args: ['https://github.com/gohugoio/hugo/releases/download/v0.92.0/hugo_extended_0.92.0_Linux-64bit.tar.gz']
- name: 'ubuntu'
  args: ['tar', 'xzf', 'hugo_extended_0.92.0_Linux-64bit.tar.gz', 'hugo']

# Bước 2: Build Hugo site
- name: 'gcr.io/cloud-builders/docker'
  args: ['run', '--rm', '-v', '$PWD:/src', '-w', '/src', 'klakegg/hugo:0.92.0', 'hugo', '--minify']

# Bước 3: Deploy lên Google Cloud Storage
- name: 'gcr.io/cloud-builders/gsutil'
  args: ['-m', 'rsync', '-r', '-c', '-d', 'public', 'gs://${_BUCKET_NAME}']

substitutions:
  _BUCKET_NAME: your-bucket-name # Thay thế bằng tên bucket của bạn

options:
  logging: CLOUD_LOGGING_ONLY


## 2. Cấu hình Trigger trong Cloud Build

### Bước 1: Truy cập Google Cloud Console
1. Mở trình duyệt web và truy cập https://console.cloud.google.com/
2. Đăng nhập bằng tài khoản Google của bạn

### Bước 2: Điều hướng đến Cloud Build
1. Trong menu bên trái, tìm và nhấp vào "Cloud Build"
2. Trong submenu của Cloud Build, chọn "Triggers"

### Bước 3: Tạo Trigger mới
1. Nhấp vào nút "Create Trigger" hoặc "Tạo Trigger"
2. Đặt tên cho trigger, ví dụ: "hugo-auto-deploy"
3. Trong phần "Event", chọn "Push to a branch"
4. Chọn repository GitHub của bạn từ danh sách (nếu chưa kết nối, làm theo hướng dẫn để kết nối GitHub)
5. Trong "Branch", nhập "^main$" để trigger chỉ kích hoạt khi có push vào branch main
6. Trong phần "Configuration", chọn "Cloud Build configuration file (yaml or json)"
7. Đảm bảo rằng đường dẫn đến file là "/cloudbuild.yaml"
8. Nhấp "Create" để tạo trigger

## 3. Cấp quyền cho Cloud Build
### Bước 1: Truy cập IAM & Admin
1. Trong Google Cloud Console, tìm và nhấp vào "IAM & Admin" trong menu bên trái
2. Chọn "IAM" từ submenu

### Bước 2: Tìm Service Account của Cloud Build
1. Tìm service account có tên bắt đầu bằng "projectNumber@cloudbuild.gserviceaccount.com"

### Bước 3: Thêm quyền
1. Nhấp vào biểu tượng chỉnh sửa (hình bút chì) bên cạnh service account
2. Nhấp "Add another role"
3. Tìm và chọn "Storage Object Creator"
4. Lặp lại bước 2-3 để thêm "Storage Object Viewer"
5. Nhấp "Save" để lưu thay đổi

## 4. Thiết lập Biến Môi trường

### Bước 1: Truy cập Trigger
1. Quay lại Cloud Build > Triggers
2. Nhấp vào trigger bạn vừa tạo

### Bước 2: Thêm biến môi trường
1. Cuộn xuống phần "Substitution variables"
2. Nhấp "Add variable"
3. Thêm các biến cần thiết, ví dụ:
   - _BUCKET_NAME: tên của Google Cloud Storage bucket
4. Nhấp "Save" để lưu thay đổi

## 5. Kiểm tra và Theo dõi

### Bước 1: Push thay đổi lên GitHub
1. Thực hiện một thay đổi nhỏ trong repository
2. Commit và push lên branch main

### Bước 2: Theo dõi quá trình build
1. Trong Google Cloud Console, đi đến Cloud Build > History
2. Bạn sẽ thấy một build mới đang chạy
3. Nhấp vào build để xem chi tiết và logs

### Bước 3: Kiểm tra website
1. Sau khi build hoàn tất, truy cập URL của website của bạn
2. Xác nhận rằng các thay đổi đã được áp dụng

## 6. Cấu hình Notifications (tùy chọn)

### Bước 1: Thiết lập Pub/Sub topic
1. Trong Google Cloud Console, đi đến Pub/Sub
2. Tạo một topic mới, ví dụ: "cloud-builds"

### Bước 2: Cấu hình Cloud Build để sử dụng Pub/Sub
1. Đi đến Cloud Build > Settings
2. Trong phần "Notifications", chọn Pub/Sub topic bạn vừa tạo

### Bước 3: Thiết lập thông báo
1. Sử dụng Cloud Functions hoặc một dịch vụ khác để đăng ký vào Pub/Sub topic
2. Cấu hình để gửi thông báo qua email hoặc Slack khi nhận được message từ topic

