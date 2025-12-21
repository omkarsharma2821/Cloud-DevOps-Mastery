# Deploying a React+Vite App on AWS EC2

This guide will help you deploy your React app on an **AWS EC2** instance using **Ubuntu**.  

## **1️⃣ Launch an EC2 Instance**  
- Go to **AWS Console → EC2 → Launch Instance**.  
- Choose an **Ubuntu** AMI (Ensure it's **Free Tier Eligible** if using Free Tier).  
- Select an **instance type** (e.g., `t2.micro` for Free Tier).  
- Create a **Key Pair** for SSH access.  
- Configure **Security Groups**:  
  - **Allow HTTP (Port 80) & HTTPS (Port 443)** for public access.  
  - **Allow SSH (Port 22)** for remote login.  

## **2️⃣ Connect to Your EC2 Instance**  
Once your instance is running, connect via SSH using your key pair:  
```sh
ssh -i your-key.pem ubuntu@your-ec2-public-ip
```
## 3️⃣ Set Up the Environment  

### Update Ubuntu  
Run the following command to update system packages:  
```sh
sudo apt-get update && sudo apt-get upgrade -y
```
By default, Ubuntu does not have npm installed. Install it using:
```sh
sudo apt install npm -y
```

## 4️⃣ Deploy Your React App
Clone Your Repository
```sh
git clone <your-repository-link>
```
Navigate to Your Project Directory
```sh
cd your-project-name
```
Install Dependencies
```sh
npm install
```
Use --host Flag to Expose Vite Server on EC2
```sh
npm run dev -- --host
```
Start the React App
```sh
npm run dev
```
## 5️⃣ Handling EC2 Public IP Changes
By default, AWS assigns a dynamic public IP that changes when the instance is restarted. To keep the same IP:
- Attach an Elastic IP (AWS allows only 1 free Elastic IP in Free Tier).
- Go to AWS Console → EC2 → Elastic IPs.
- Allocate a new Elastic IP and associate it with your EC2 instance.

Now, your app will remain accessible even after a reboot.
---

✍️ **Author**: *Omkar Sharma*  
📬 *Feel free to connect on [LinkedIn](https://www.linkedin.com/in/omkarsharmaa/) or explore more on [GitHub](https://github.com/omkarsharma2821)* 