# From Dockerfile to AWS Elastic Beanstalk: A Real-World Deployment Case Study

Imagine you have developed a React application using Vite, containerized it using Docker, and successfully pushed your Docker image to Docker Hub.

Now, the next objective is to deploy that application on AWS.

Naturally, you start exploring AWS Elastic Beanstalk.

The idea sounds straightforward:

- Upload your application.
- Let AWS provision the infrastructure.
- Deploy your application.
- Access it through an environment URL.

Let's walk through the entire implementation.

## 1. Understanding the Architecture

Before starting the deployment, it is important to understand what Elastic Beanstalk actually does.

AWS Elastic Beanstalk is a Platform as a Service (PaaS) offering that simplifies application deployment and infrastructure management.

Instead of manually creating and configuring every AWS resource, Elastic Beanstalk can provision and manage resources such as:

- Amazon EC2
- Elastic Load Balancing
- Auto Scaling Groups
- Amazon CloudWatch
- Security Groups

### Important components of Elastic Beanstalk

| Component           | Explanation                                                            |
| ------------------- | ---------------------------------------------------------------------- |
| Application         | Logical container for your application versions and environments       |
| Application Version | A specific version of your application code                            |
| Environment         | The infrastructure where your application runs                         |
| Environment Tier    | Determines whether the app serves web requests or runs background jobs |
| Platform            | Runtime and OS configuration, such as Node.js on Amazon Linux          |
| Configuration       | Settings for instances, scaling, networking, and deployment            |


For this implementation, the architecture looks like this:

**Application Deployment Flow**

Developer Machine → Application ZIP → AWS Elastic Beanstalk → EC2 Instance → Docker Container → React Application

Elastic Beanstalk manages much of the infrastructure provisioning, while Docker handles application containerization.

## 2. Preparing the Application

The application was developed using React and Vite.

Before deploying it, I prepared the Docker configuration.

### Project Structure

The project contained the following files:

```text
my-react-app/
│
├── Dockerfile
├── nginx.conf
├── .dockerignore
├── package.json
├── package-lock.json
├── index.html
├── vite.config.js
├── eslint.config.js
│
├── public/
├── src/
└── README.md
```

## 3. Create an Elastic Beanstalk Application

1. Sign in to the AWS Management Console.
2. Search for **Elastic Beanstalk**.
3. Select the AWS Region: `Asia Pacific (Mumbai) – ap-south-1`.
4. Click **Create application**.

Configure the application:

![omkarsharma2821](https://dev-to-uploads.s3.us-east-2.amazonaws.com/uploads/articles/bcrh1wguuqiv9s9r0gcv.png)

Click Next or proceed to environment creation.

An Elastic Beanstalk Application is a logical container that holds application versions and environments.

## 4. Create the Environment

Select **Create a new environment**.

Configure the environment:

| Parameter        | Value                                          |
| ---------------- | ---------------------------------------------- |
| Environment name | `react-docker-env`                             |
| Domain           | Auto-generated or custom                       |
| Platform         | Docker                                         |
| Platform branch  | Select the available supported Docker platform |
| Platform version | Select the recommended version                 |

The Web Server Environment is suitable for applications that receive HTTP/HTTPS requests from users.

![omkarsharma2821](https://dev-to-uploads.s3.us-east-2.amazonaws.com/uploads/articles/2iw3pk31prpixgagwnwo.png)

![omkarsharma2821](https://dev-to-uploads.s3.us-east-2.amazonaws.com/uploads/articles/lddeva7aenavls12qmby.png)

## 5. Configure the Platform

Under the Platform section:

1. Select Docker.
2. Select the recommended platform branch.
3. Select the platform version.

Elastic Beanstalk will use the selected Docker platform to run your containerized application.

For this implementation, we will deploy a pre-built weather-app using local zip file upload or we can use pre-buil docker Hub image using `Dockerrun.aws.json`.


![omkarsharma2821](https://dev-to-uploads.s3.us-east-2.amazonaws.com/uploads/articles/3dfbubhoo9ej5l5c1yeh.png)


## 6. Configure Application Code

Under the Application Code section:

Select:

**Upload your code**

Provide the following details:

| Parameter           | Value                                    |
| ------------------- | ---------------------------------------- |
| Source              | Local file                               |
| Application version | `weather-app`                            |
| Source bundle       | ZIP file containing `Dockerrun.aws.json` |

The ZIP structure should be:

```plaintext
deployment.zip
└── Dockerrun.aws.json || Dockerfile
```

The JSON file should contain your Docker Hub image reference:

```json
{
  "AWSEBDockerrunVersion": "1",
  "Image": {
    "Name": "omkarsharma2821/weather-app:latest",
    "Update": "true"
  },
  "Ports": [
    {
      "ContainerPort": "80"
    }
  ]
}
```

Replace the image name with your actual Docker Hub image.


## 7. Configure Service Access and IAM Roles

IAM roles are important because Elastic Beanstalk requires permissions to manage AWS resources and EC2 instances.

Configure the following:

| Parameter            | Configuration                                         |
| -------------------- | ----------------------------------------------------- |
| Service role         | `aws-elasticbeanstalk-service-role`                   |
| EC2 instance profile | `aws-elasticbeanstalk-ec2-role`                       |
| EC2 key pair         | Select an existing key pair if SSH access is required |

The role names above are examples; your account may use different names.

![omkarsharma2821](https://dev-to-uploads.s3.us-east-2.amazonaws.com/uploads/articles/rs7p5reegqxj4vbmd78b.png)

![omkarsharma2821](https://dev-to-uploads.s3.us-east-2.amazonaws.com/uploads/articles/60c9ucuhklwikt31amyx.png)

### Service Role

The Elastic Beanstalk service role allows the Elastic Beanstalk service to perform management operations on your behalf.

For example:

- Monitor environment health.
- Manage environment resources.
- Perform environment updates.

### EC2 Instance Profile

The EC2 instance profile provides permissions to the EC2 instances running your application.

For example:

- Retrieve application deployment bundles from S3.
- Publish logs and metrics to CloudWatch.
- Access AWS resources when required.

For a public Docker Hub image, Docker Hub authentication is not required.

For a private image, configure registry authentication securely.


## 8. Configure Infrastructure

Under the Infrastructure section, configure the underlying compute and networking resources.

For a learning environment, you can start with a Single Instance environment to reduce costs.

| Parameter          | Suggested Configuration                  |
| ------------------ | ---------------------------------------- |
| Environment type   | Single instance                          |
| Instance type      | `t3.micro` (if available and suitable)   |
| EC2 architecture   | Select compatible architecture           |
| Root volume        | Default configuration                    |
| EC2 security group | Elastic Beanstalk-created security group |
| EC2 key pair       | Optional                                 |
| VPC                | Default VPC for a basic lab              |
| Subnet             | Select an appropriate subnet             |

### Important

For a Single Instance environment, Elastic Beanstalk generally runs the application on one EC2 instance without a load balancer.

For a highly available production environment, select a Load Balanced environment and configure multiple instances across Availability Zones.


## 9. Configure Networking

Under the networking configuration:

| Parameter         | Suggested Configuration                        |
| ----------------- | ---------------------------------------------- |
| VPC               | Default VPC or custom VPC                      |
| Public IP address | Enabled for a basic public single-instance lab |
| Subnets           | Select appropriate subnets                     |
| Security Group    | Allow required application traffic             |

For a public web application:

- Allow HTTP on port 80.
- Allow HTTPS on port 443 if HTTPS is configured.
- Restrict SSH access to trusted IP addresses if SSH is enabled.

Do not expose unnecessary ports such as Docker's internal management ports.

## 10. Configure Additional Services

Review the Services section and configure the required settings.

### Monitoring

Enable application and environment monitoring.

Elastic Beanstalk integrates with Amazon CloudWatch for monitoring environment health and metrics.

### Managed Updates

Configure managed platform updates according to your maintenance requirements.

### Logs

Enable log streaming or log retention where required.

### Notifications

Configure notifications for environment events if needed.

### Understand the Provisioning Process

During environment creation, Elastic Beanstalk may perform the following operations:

1. Create the environment.
2. Create or configure IAM-related resources.
3. Create security groups.
4. Launch EC2 instances.
5. Configure the Docker runtime.
6. Retrieve the application deployment bundle.
7. Pull the Docker image from Docker Hub.
8. Start the Docker container.
9. Configure application health monitoring.

The exact resources depend on your environment configuration.

## Verify the Deployment

Once the environment is created:

1. Open the Elastic Beanstalk environment dashboard.
2. Check the environment health status.
3. Locate the environment URL.
4. Open the URL in your browser.
5. Verify that your React application is running.

![omkarsharma2821](https://dev-to-uploads.s3.us-east-2.amazonaws.com/uploads/articles/05o8xbmehwz1b6qzfbku.png)

You can also connect to the underlying EC2 instance and inspect the running container:

```shell
docker ps
```

View container logs:

```shell
docker logs CONTAINER_ID
```

Common deployment errors:

| Error                       | Possible Cause                            | Resolution                               |
| --------------------------- | ----------------------------------------- | ---------------------------------------- |
| Dockerfile missing          | Incorrect ZIP structure                   | Place Dockerfile at ZIP root             |
| Dockerrun.aws.json missing  | Incorrect source bundle                   | Include the JSON file at ZIP root        |
| Docker image pull failed    | Incorrect Docker Hub image name           | Verify the image reference               |
| Application unavailable     | Container port mismatch                   | Verify container port configuration      |
| Environment health degraded | Application startup or health-check issue | Inspect application logs                 |
| IAM permission denied       | Missing IAM permissions                   | Review service role and instance profile |

-----

✍️ **Author**: *Omkar Sharma*  
📬 *Feel free to connect on [LinkedIn](https://www.linkedin.com/in/omkarsharmaa/) or explore more on [GitHub](https://github.com/omkarsharma2821)*