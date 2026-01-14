```
#!/bin/bash
apt-get update -y
apt-get install -y nginx

systemctl start nginx
systemctl enable nginx

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Welcome to $(hostname)</title>
  <style>
    body {
      background: linear-gradient(135deg, #1e3c72, #2a5298);
      color: white;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }
    h1 {
      font-size: 3em;
      margin: 0.2em 0;
    }
    p {
      font-size: 1.2em;
      color: #cce3ff;
    }
    .hostname {
      background: #ffffff33;
      padding: 0.5em 1em;
      border-radius: 10px;
      font-weight: bold;
    }
  </style>
</head>
<body>
  <h1>Welcome to Omkar Server!</h1>
  <p>This server is proudly hosted as:</p>
  <div class="hostname">$(hostname)</div>
</body>
</html>
EOF
```