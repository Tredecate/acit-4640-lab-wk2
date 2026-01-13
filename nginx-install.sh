# nginx-install.sh
#!/bin/bash

ssh -i "${SSH_KEY_PATH}" "${NAME}@${IP_ADDR}" << EOF
# Update package lists
sudo apt update -y

# Install Nginx
sudo apt install nginx -y

# Start the Nginx service
sudo systemctl start nginx

# Enable Nginx to start on boot
sudo systemctl enable nginx
EOF
