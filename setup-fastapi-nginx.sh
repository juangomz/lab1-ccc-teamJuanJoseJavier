#!/bin/bash
set -e

APP_DIR="/home/ec2-user/fastapiapp"
USER="ec2-user"

yum update -y
yum install -y nginx python3 python3-pip

pip3 install --user fastapi uvicorn

mkdir -p $APP_DIR

cat > $APP_DIR/app.py << 'EOF'
from fastapi import FastAPI
import socket, datetime

app = FastAPI()

@app.get("/")
def root():
    return {
        "message": "hello from fastapi behind nginx",
        "host": socket.gethostname(),
        "time": datetime.datetime.utcnow().isoformat() + "Z"
    }

@app.get("/health")
def health():
    return {"ok": True}
EOF

chown -R $USER:$USER $APP_DIR

cat > /etc/systemd/system/fastapi.service << 'EOF'
[Unit]
Description=FastAPI app with Uvicorn
After=network.target

[Service]
User=ec2-user
WorkingDirectory=/home/ec2-user/fastapiapp
Environment="PATH=/home/ec2-user/.local/bin:/usr/local/bin:/usr/bin"
ExecStart=/home/ec2-user/.local/bin/uvicorn app:app --host 127.0.0.1 --port 8000
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable --now fastapi

cat > /etc/nginx/conf.d/fastapi.conf << 'EOF'
server {
    listen 80;
    server_name "";

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
EOF

nginx -t
systemctl enable --now nginx
systemctl reload nginx
