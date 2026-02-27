## Setting Up Jenkins on AWS EC2 (Ubuntu)

### Launch EC2 Instance

- Launch an **Ubuntu Server** EC2 instance.
- Instance type: Free Tier eligible (e.g., t2.micro).
- Storage: 15 GB (Free Tier eligible).
- Allow **Port 80** in the Security Group (HTTP traffic).
- (Recommended) Also allow **Port 8080** for Jenkins default access.

### What is Jenkins?

Jenkins is a self-contained, open source automation server which can be used to automate all sorts of tasks related to building, testing, and delivering or deploying software.

Jenkins can be installed through native system packages, Docker, or even run standalone on any machine with a Java Runtime Environment (JRE) installed.

### Installation Steps (Ubuntu/Debian)

Official Documentation:  
https://www.jenkins.io/doc/book/installing/linux/#debianubuntu

### Step 1: Update Packages

```bash
sudo apt update
```

### Step 2: Install Java (Required Before Jenkins)

```bash
sudo apt install fontconfig openjdk-21-jre
java -version
```

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/r6g03my1nstrepx57g9n.png)


On Debian/Ubuntu, it is strongly recommended to install Java **before** Jenkins. If Jenkins is installed first and Java is added later, the Jenkins service may fail to start with:

```
jenkins: failed to find a valid Java installation
```

### Install Jenkins (Long Term Support Release)

```bash
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update
sudo apt install jenkins
```

### Check Jenkins Service Status

```bash
sudo systemctl status jenkins
```

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/jofuhezo6ig9rznflkw6.png)

If the service is active and running, Jenkins has been installed successfully.

> To ensure Jenkins is active and running whenever you reboot or restart your server, check whether the service is enabled:

```bash
sudo systemctl is-enabled jenkins
```

* If the output is `enabled`, Jenkins will start automatically on boot.
* If the output is `disabled`, run the following command:

```bash
sudo systemctl enable jenkins
```

### Access Jenkins in Browser

1. Go to the **Public IP** of your EC2 instance.
2. Open your browser and type:

```
http://<public-ip>:8080
```

You will see the **Getting Started** page.

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/ya7jcyanp3vki1m7frvl.png)

### Unlock Jenkins

You need to enter the initial admin password stored in the following file on your server:

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/bbxp593cdhncunmxnxo5.png)

Copy the password and paste it into the Jenkins setup page.

### Install Plugins

After unlocking Jenkins, click on:

**Install suggested plugins**

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/huual83b283q458ovuo1.png)

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/f5v964etsl1xuvio0ibg.png)

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/pb3bkv60r10td71kja2o.png)

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/asztirdnbcr3rsnvcuwx.png)

>### **_Congratulations you have setup the Jenkins_**

---

✍️ **Author**: *Omkar Sharma*  
📬 *Feel free to connect on [LinkedIn](https://www.linkedin.com/in/omkarsharmaa/) or explore more on [GitHub](https://github.com/omkarsharma2821)*