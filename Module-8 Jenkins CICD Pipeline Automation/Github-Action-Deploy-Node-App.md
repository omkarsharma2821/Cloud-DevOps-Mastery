# Deploy Node.js & Express Application Using CI/CD (GitHub Actions + Docker)

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/4ps32jmakv6wuq4qn4d5.png)

## Quick Flow before deep dive

1. Developer pushes code to GitHub
2. GitHub Actions triggers pipeline
3. Pipeline connects to EC2 via SSH
4. Pulls latest code
5. Rebuilds Docker image
6. Runs container using Docker Compose
7. Application is live on EC2 public IP

### Prerequisites

* Node.js (v16+) and npm installed on local machine

* Git installed on local machine and basic commands knowledge

* Docker installed on local machine

* GitHub account

* AWS account

* Basic cloud/devops knowledge

## 1. Create a Simple Node.js + Express Application

Initialize a Node.js project:

```bash
npm init
```

Install required dependencies:

```bash
npm install express
npm install @types/express --save-dev
```

## 2. Update `package.json`

Add the following:

```json
{
  "name": "node-app",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "start": "node index.js"
  }
}
```

## 3. Create `index.js`

```js
import express from 'express';

const app = express();
const PORT = process.env.PORT || 8080;

app.get('/', (req, res) => {
  res.send('Hello from the server!');
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
```

## 4. Create a Dockerfile

```Dockerfile
FROM node:22-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 8080

CMD [ "node" , "index" ]
```

## 5. Build Docker Image

```bash
docker build -t node-app .
```

### Explanation

* `docker build` → Builds a Docker image
* `-t node-app` → Tags the image with the name `node-app`
* `.` → Refers to the current directory (build context)

**Purpose of `.` (dot):**
It tells Docker to use the current folder as the context, meaning all files in this directory are available to the Docker daemon during build.

## 6. Run the Container

> Note: Before running below command make sure docker engine is running state........ for testing trying to run container before creating compose file after creating compose file we dont need to run container manually just compose up commmand will take care of everything

```bash
docker run -d -p 8080:8080 --rm node-app
```

### Explanation

* `-d` → Runs container in detached mode
* `-p 8080:8080` → Maps host port 8080 to container port 8080
* `--rm` → Automatically removes the container when it stops

**Purpose of `--rm`:**

* Prevents accumulation of stopped containers
* Keeps the system clean
* Useful for temporary/testing containers


## 7. Test Using curl

```bash
curl http://localhost:8080
```
![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/4kubj59fa3vovhn8kr2n.png)

> curl is a command-line tool used to transfer data to and from a server using URLs.

Expected output:

```plaintext
Hello from the server!
```

## 8. Create Docker Compose File

Create `docker-compose.yml`:

```yaml
services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    restart: unless-stopped
    ports:
      - "8080:8080"
```

### Run the Application

```bash
docker compose up -d
```

> In browser test the application 

![omkar sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/7mayfok9id1v7u88l5qo.png)
### Stop the Application

```bash
docker compose down
```

### Verify Again

```bash
curl http://localhost:8080
```

## 9. Push Code to GitHub

Check my github repo for this task - [omkarsharma2821](https://github.com/omkarsharma2821)

Initialize Git and push code:

```bash
git init
git add .
git commit -m "Initial commit"

git branch -M main

git remote add origin <your-repo-url>

git push -u origin main
```

## 10. Create an EC2 Instance (Ubuntu)

Once the instance is created, connect via SSH and run:

```bash
sudo apt update
sudo apt upgrade -y
```

### Importance of Update & Upgrade

* Updates package list from repositories
* Installs latest security patches
* Fixes vulnerabilities
* Ensures system stability before installing new software

## 11. Install Docker & Docker Compose

### Option 1: Install from Ubuntu Repository

```bash
sudo apt install docker.io -y
sudo apt install docker-compose -y
```

### Option 2: Install from Official Docker Website

Recommended for:

* Latest stable version
* Better performance and features
* Production environments


## 12. Run Application on EC2

Clone your repository:

```bash
git clone <your-repo-url>
cd <repo-name>
```

Run:

```bash
docker compose up -d
```

### Test Application

```bash
curl http://<EC2-PUBLIC-IP>:8080
```

> make sure you have allowed port no. 8080 in the instance security group to get the response.

## 13. Setup GitHub Actions (CI/CD)

Create workflow file:

```yaml
.github/workflows/deploy.yml
```

Example:

```yaml
name: Deploy Node App

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Deploy via SSH
        uses: appleboy/ssh-action@v1.0.3
        with:
          host: ${{ secrets.SSH_HOST }}
          username: ${{ secrets.SSH_USERNAME }}
          key: ${{ secrets.SSH_KEY }}
          script: |
            set -e

            cd /home/ubuntu/node-app/Node.js-App-Deploy-Github-Action

            echo "Pulling latest code..."
            git pull origin main

            echo "Stopping existing containers..."
            docker compose down

            echo "Removing unused images..."
            docker image prune -f

            echo "Building and starting containers..."
            docker compose up -d --build

            echo "Deployment completed successfully"
```

`**set -e**
Stops execution if any command fails
Prevents partial deployments
**Cleanup Step**
docker image prune -f
Prevents disk space issues over time`

## 14. Generate SSH Keys

On local machine:

```bash
ssh-keygen -t rsa -b 4096
```

### Setup

* Copy public key to EC2:

```bash
cat ~/.ssh/id_rsa.pub
```

Paste it into:

```ssh
~/.ssh/authorized_keys
```

* Add private key to GitHub:

Go to:

```plaintext
GitHub → Repo → Settings → Secrets → Actions
```

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/hobdvgqlo8sbungtoqd2.png)


Add:

```properties
SSH_KEY - <your-key>
SSH_HOST - <public-ip of ec2>
SSH_USERNAME - <root or ubuntu>
```

## Final Flow

1. Developer pushes code to GitHub
2. GitHub Actions triggers pipeline
3. Pipeline connects to EC2 via SSH
4. Pulls latest code
5. Rebuilds Docker image
6. Runs container using Docker Compose
7. Application is live on EC2 public IP

---

✍️ **Author**: *Omkar Sharma*  
📬 *Feel free to connect on [LinkedIn](https://www.linkedin.com/in/omkarsharmaa/) or explore more on [GitHub](https://github.com/omkarsharma2821)*
