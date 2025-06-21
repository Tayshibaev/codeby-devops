#!/bin/bash

apt-get update
apt-get install -y apache2 openssl

mkdir -p /etc/apache2/ssl

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/apache2/ssl/example.local.key \
  -out /etc/apache2/ssl/example.local.crt \
  -subj "/C=RU/ST=Moscow/L=Moscow/O=Example/OU=IT/CN=example.local"

cat > /etc/apache2/sites-available/example.local.conf <<EOF
<VirtualHost *:80>
    ServerName example.local
    ServerAlias www.example.local
    Redirect permanent / https://example.local/
</VirtualHost>

<VirtualHost *:443>
    ServerName example.local
    ServerAlias www.example.local
    DocumentRoot /var/www/html

    SSLEngine on
    SSLCertificateFile /etc/apache2/ssl/example.local.crt
    SSLCertificateKeyFile /etc/apache2/ssl/example.local.key

    <Directory /var/www/html>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    RewriteEngine On
    RewriteCond %{HTTP_HOST} ^www\.example\.local [NC]
    RewriteRule ^(.*)$ https://example.local\$1 [L,R=301]

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

a2ensite example.local.conf
a2enmod ssl rewrite
systemctl restart apache2

echo "192.168.56.11 example.local www.example.local" >> /etc/hosts

echo "<h1>Welcome to example.local (HTTPS)</h1>" > /var/www/html/index.html