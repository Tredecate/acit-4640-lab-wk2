# ACIT 4640 - Lab 2

**Group Members**
- Thomas De Zwart
- Charley Liao
- Ramnik Mudaliar

## SSH Key Generation

To create the SSH key pair for this lab, we ran the following command:

```bash
ssh-keygen -t ed25519 -f ~/.ssh/wkone -C "Key for Lab 2"
```

- The `-t` flag lets us specify the type of key we want to create. We chose `ed25519`
- The `-f` flag lets us specify the output location and name of the keyfiles. We followed the lab instructions and chose `wkone`.
- The `-C` flag lets us add a comment to the key. And... Why not? :)

## Environment Variables

Create a configuration file named config.env

```bash
# config.env

export NAME="admin"
export IP_ADDR="35.89.130.148"
export SSH_KEY_PATH="~/.ssh/wkone"
```

## Script Files

**Script 1: nginx-install**

```bash
# nginx-install
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
```

**Script 2: document-write**

```bash
# document-write
#!/bin/bash

# store the current date in dd/mm/yyyy format
curdate=$(date +"%d/%m/%Y")

# connect to server with creds and IP from env
# then, use nested heredocs with different EOF indicators
# the outer heredoc passes everything through SSH to the server
# the next line cats the inner heredoc (with the HTML), and pipes the result to an elevated tee to write to /var/www/html/index.html
# the inner heredoc ends, and then we restart the nginx service
ssh -i "${SSH_KEY_PATH}" -T "${NAME}"@"${IP_ADDR}" << EOF
cat << END | sudo tee /var/www/html/index.html
<!DOCTYPE html>
<html lang='en'>
<head>
  <meta charset='UTF-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1.0'>
  <title>Hello World</title>
</head>
<body>
  <h1>Hello World!</h1>
  <p>Today's date is: ${curdate}</p>
</body>
</html>
END
sudo systemctl restart nginx
EOF
```

### To Run Scripts

```bash
source config.env
chmod +x nginx-install
chmod +x document-write
./nginx-install
./document-write
```

### Result of the Scripts

![alt text](<Screenshot 4 Result.png>)

