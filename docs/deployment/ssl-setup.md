# Cách Cấu hình SSL cho Website

## Giới thiệu
Bảo mật SSL là cần thiết để đảm bảo kết nối an toàn giữa người dùng và website của bạn. Chúng ta sẽ sử dụng Let's Encrypt để cấu hình SSL miễn phí.

## Bước 1: Cài đặt Certbot
Certbot là một công cụ tự động hóa để lấy và cài đặt chứng chỉ SSL từ Let's Encrypt.

1. Cài đặt Certbot:

sudo apt-get update
sudo apt-get install certbot

## Bước 2: Lấy Chứng chỉ SSL
1. Chạy Certbot để lấy chứng chỉ:

sudo certbot certonly --webroot -w /path/to/your/website -d yourdomain.com -d www.yourdomain.com

Thay `/path/to/your/website` bằng đường dẫn thực tế đến thư mục gốc của website, và `yourdomain.com` bằng tên miền của bạn.

2. Làm theo hướng dẫn trên màn hình để hoàn tất quá trình.

## Bước 3: Cấu hình Web Server
### Nếu sử dụng Nginx:
1. Chỉnh sửa file cấu hình Nginx:
   
sudo nano /etc/nginx/sites-available/yourdomain.com

2. Thêm cấu hình SSL:
```nginx
server {
    listen 443 ssl;
    server_name yourdomain.com www.yourdomain.com;

    ssl_certificate /etc/letsencrypt/live/yourdomain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/yourdomain.com/privkey.pem;

    # Các cấu hình khác...
}

3. Kiểm tra và khởi động lại Nginx:

sudo nginx -t
sudo systemctl restart nginx

Nếu sử dụng Apache:

1.Chỉnh sửa file cấu hình Apache:

sudo nano /etc/apache2/sites-available/yourdomain.com.conf

2.Thêm cấu hình SSL:

<VirtualHost *:443>
    ServerName yourdomain.com
    ServerAlias www.yourdomain.com

    SSLEngine on
    SSLCertificateFile /etc/letsencrypt/live/yourdomain.com/fullchain.pem
    SSLCertificateKeyFile /etc/letsencrypt/live/yourdomain.com/privkey.pem

    # Các cấu hình khác...
</VirtualHost>

3.Kích hoạt module SSL và khởi động lại Apache:

sudo a2enmod ssl
sudo systemctl restart apache2

Bước 4: Tự động Gia hạn Chứng chỉ

Chứng chỉ Let's Encrypt hết hạn sau 90 ngày. Để tự động gia hạn:

1.Tạo một cron job:

sudo crontab -e

2.Thêm dòng sau:

0 12 1 * * /usr/bin/certbot renew --quiet

Kết luận
Bây giờ website của bạn đã được bảo vệ bằng SSL. Đảm bảo kiểm tra định kỳ để đảm bảo chứng chỉ vẫn còn hiệu lực và được gia hạn đúng hạn.



