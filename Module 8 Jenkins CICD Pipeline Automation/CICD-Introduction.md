Developers from the Application team write the code and push it to **GitHub**.

Now, instead of manually building and deploying the application, we use **Jenkins** as a CI/CD tool to automate the entire process.

Here’s how the flow works:

1. Developers commit and push the code to **GitHub**.
2. Jenkins is connected to the repository using a webhook.  
   Whenever new code is pushed, Jenkins automatically triggers a pipeline.
3. Jenkins pulls the latest code and starts the **build process**.
4. During the build stage, **Docker** is used to create a Docker image from that code.
5. The Docker image is then pushed to a container registry (like Docker Hub or ECR).
6. In the deployment stage, Jenkins deploys that image either:

   - On an **Amazon EC2** instance, or  
   - On a **Kubernetes** cluster.

7. Once the application is live, monitoring tools like **Prometheus** are used to monitor application health, metrics, and performance.

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/t8degmf4msdmeuibddkh.png)

### In Simple Terms

Jenkins acts as the brain of the CI/CD pipeline.  
It automates:

- Code integration (Continuous Integration)
- Testing and building
- Docker image creation
- Deployment to servers or Kubernetes
- And ensures the whole process runs automatically whenever new code is pushed

This is the concept of CI/CD using Jenkins — automation from code commit to production deployment and monitoring, without manual intervention.