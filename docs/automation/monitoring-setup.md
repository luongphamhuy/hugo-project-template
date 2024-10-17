
4. `docs/automation/monitoring-setup.md`:

```markdown
# Hướng dẫn Thiết lập Monitoring cho Website

## Giới thiệu
Monitoring là một phần quan trọng trong việc duy trì hiệu suất và độ tin cậy của website. Chúng ta sẽ sử dụng Google Cloud Monitoring để theo dõi website.

## Bước 1: Kích hoạt Google Cloud Monitoring

1. Truy cập [Google Cloud Console](https://console.cloud.google.com/).
2. Đi tới "Monitoring" trong menu chính.
3. Nếu chưa kích hoạt, làm theo hướng dẫn để kích hoạt Monitoring cho project của bạn.

## Bước 2: Tạo Dashboard

1. Trong Monitoring Console, chọn "Dashboards" từ menu bên trái.
2. Click "Create Dashboard".
3. Đặt tên cho dashboard của bạn.

## Bước 3: Thêm Các Metric

### Uptime Check
1. Trong dashboard, click "Add Widget" > "Line".
2. Chọn "Resource Type" là "Uptime Check".
3. Chọn metric "Check Success" hoặc "Latency" tùy theo nhu cầu.
4. Cấu hình các thông số khác như khoảng thời gian, tần suất kiểm tra.

### Cloud Storage Metrics (nếu sử dụng Cloud Storage)
1. Thêm widget mới, chọn "Resource Type" là "Cloud Storage".
2. Chọn các metric như "Total Object Count", "Total Bytes", "Received Bytes".

### Cloud CDN Metrics (nếu sử dụng Cloud CDN)
1. Thêm widget cho "Resource Type" là "Cloud CDN".
2. Chọn metric như "Request Count", "Total Latency", "Cache Hit Ratio".

## Bước 4: Cấu hình Alerts

1. Trong Monitoring Console, chọn "Alerting" từ menu bên trái.
2. Click "Create Policy".
3. Chọn các điều kiện cho cảnh báo (ví dụ: uptime check fails, latency exceeds threshold).
4. Cấu hình thông báo (email, SMS, hoặc tích hợp với các dịch vụ khác như Slack).

## Bước 5: Thiết lập Logging

1. Đi tới "Logging" trong Google Cloud Console.
2. Tạo các log filter để theo dõi các sự kiện quan trọng.
3. Cấu hình log-based metrics nếu cần.

## Bước 6: Cấu hình Error Reporting

1. Đi tới "Error Reporting" trong Google Cloud Console.
2. Kích hoạt Error Reporting cho project của bạn.
3. Cấu hình thông báo cho các lỗi nghiêm trọng.

## Bước 7: Thiết lập Tracing (nếu cần)

1. Đi tới "Trace" trong Google Cloud Console.
2. Kích hoạt Cloud Trace API nếu chưa được kích hoạt.
3. Tích hợp Cloud Trace vào ứng dụng của bạn nếu cần theo dõi chi tiết hiệu suất.

## Kết luận
Với các bước trên, bạn đã thiết lập một hệ thống monitoring cơ bản cho website của mình. Hãy thường xuyên xem xét và điều chỉnh các cấu hình monitoring để đảm bảo bạn luôn nắm bắt được tình trạng và hiệu suất của website.
