## Docker Problem Statement - What Problem Does Docker Solve?

“Same code works on my machine but not on yours.”

### Why does this happen?
Environment Replication Issues

### Example Scenario
- You worked on a project for the past 3 months.
- During development, you installed multiple dependencies, libraries, and packages.
- Now you want to onboard another developer.
- You shared the source code and asked them to install dependencies with exact versions.

### Challenges
- Hard to remember specific versions over time.
- New developers may install latest versions instead of required ones.
- Latest versions may introduce breaking changes.
- Suppose you put extra effort to remember the version and dependencies but what if they are using diff OS in that case if Windows CLI you are using will not work in MAC.
- Example:
  - Your project uses Node.js 14.x
  - Another developer installs Node.js 18.x
  - Result: Application may break or behave differently.

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/6pjjltawl7yslx55xv9g.png)

Docker solves this by standardizing environments so applications run the same everywhere.


## Installation of Docker CLI & Docker Desktop

Download Docker Desktop from:
https://www.docker.com/products/docker-desktop/

Docker Desktop includes:
- Docker CLI
- Docker Engine
- Docker Compose
- GUI Dashboard


## Understanding Images vs Containers

### Docker Images
- Preconfigured read-only templates.
- Include:
  - Base OS (optional)
  - Runtime (Node, Python, Java, etc.)
  - Dependencies
  - Application setup
- Used to create containers.
- Images act as blueprints.

### Docker Containers
- Running instances of Docker Images.
- Package application and dependencies together.
- Lightweight compared to VMs.
- Share host OS kernel (not a full OS like VMs).
- Containers are running applications created from images.


## Running Ubuntu Image in a Container

```
docker run -it <image_name>
```
Example:

```bash
docker run -it ubuntu
```

If the image is not available locally, Docker pulls it from Docker Hub automatically.

---

## Useful Docker Commands

### List Containers

```bash
docker container ls -a
```

### List Images

```bash
docker image ls
```

### Enter an Existing Running Container

```bash
docker exec -it <container_name> bash
```

## Multiple Containers

Start a Container:

```bash
docker start <container_name>
```

Stop a Container:

```bash
docker stop <container_name>
```

### Key Concept

* Multiple containers can run from the same image.
* Each container has an isolated environment.
* Example:

  * Create directory in Container 1
  * Create directory in Container 2
  * Both remain isolated from each other.


![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/ah4l367gs3rguk8o8ied.png)


## Port Mapping

```bash
docker run -it -p <local_machine_port>:<container_port> <image_name>
```

Example:

```bash
docker run -it -p 3000:3000 omkarsharma2821/omkar-node-app
```

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/6ffcymh6eiist6qzpups.png)


![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/xzvxa6s6tyuyganw0ehl.png)


Allows access to container services from local machine.


## Environment Variables

```bash
docker run -it -e PORT=4000 -p 4000:4000 <image_name>
```

Used to configure applications dynamically inside containers.


## Dockerization of a Node.js Application

Initialize Node Project:

```bash
npm init
```

Install Express:

```bash
npm install express
```

Build Docker Image:

```bash
docker build -t omkar-node-app .
```

> As if now the img is avaialbel locally to push to hub.docker.com you need to run the following coommands

Login first

```
docker login

```
Tag your image with latest

```
docker tag <local_image_name>:latest <dockerhub_username>/<repo_name>:latest
```

Example

```
docker tag omkar-nodejs:latest omkarsharma2821/omkar-node-app:latest

```
Push to docker hub

```
docker push <dockerhub_username>/<repo_name>:latest

```
Example

```
docker push omkarsharma2821/omkar-node-app:latest

```

## Summary

* Docker ensures consistent environments across machines.
* Images are templates.
* Containers are running instances.
* Supports isolated environments, easy onboarding, and scalable deployments.
* Essential for modern development workflows and microservices architecture.

---

✍️ **Author**: *Omkar Sharma*  
📬 *Feel free to connect on [LinkedIn](https://www.linkedin.com/in/omkarsharmaa/) or explore more on [GitHub](https://github.com/omkarsharma2821)*
