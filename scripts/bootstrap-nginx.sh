#!/bin/bash
# Update the system
sudo yum update -y

# Install nginx
sudo yum install -y nginx

# Start nginx service
sudo systemctl start nginx

# Enable nginx to start on boot
sudo systemctl enable nginx

# Get instance ID (works with IMDSv1 and IMDSv2)
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600" 2>/dev/null) || true
if [ -n "$TOKEN" ]; then
    INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id 2>/dev/null)
else
    INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id 2>/dev/null)
fi
INSTANCE_ID=${INSTANCE_ID:-unknown}

# Create a simple HTML page
cat > /tmp/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>Lab 1 - Cloud Computing</title>
</head>
<body>
    <h1>Welcome to Lab 1!</h1>
    <p><strong>Instance ID:</strong> ${INSTANCE_ID}</p>
</body>
</html>
EOF
sudo mv /tmp/index.html /usr/share/nginx/html/index.html

# Restart nginx to serve the new content
sudo systemctl restart nginx

# Verify nginx is running
sudo systemctl status nginx
