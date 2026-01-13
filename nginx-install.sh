# nginx-install.sh
# Script 1

#!/usr/bin/env bash

source ./config.env

echo "Connect to server ${NAME}@${IP_ADDR} to install Nginx"

ssh -i "${SSH_KEY_PATH}" "${NAME}@${IP_ADDR}" << 'EOF'

    # Update package lists
    echo "Updating package lists..."
    sudo apt update -y

    # Install Nginx
    echo "Installing Nginx..."
    sudo apt install nginx -y

    # Start the Nginx service
    echo "Starting Nginx..."
    sudo systemctl start nginx

    # Enable Nginx to start on boot
    echo "Enabling Nginx..."
    sudo systemctl enable nginx

    # Verify status
    sudo systemctl status nginx --no-pager | head -n 5

EOF

echo "Nginx installation complete."
