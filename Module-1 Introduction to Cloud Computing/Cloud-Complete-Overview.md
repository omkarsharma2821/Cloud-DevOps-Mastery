## What Is Cloud Computing?

Cloud computing is the practice of renting computing resources such as servers, storage, networking, databases, and software from a third-party provider over the internet. Instead of owning and maintaining physical hardware, users access these resources on demand and pay only for what they use.

In simple terms, cloud computing allows you to store data and run applications on remote servers hosted over the internet rather than on local machines or on-premises infrastructure.


![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/fp6tktgilx2l24wlq82v.png)


## Key Features of Cloud Computing


![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/7jxgl7ochwp6o00l15lz.png)

- **Scalability**  
  Ability to allocate and deallocate resources based on demand.

- **Elasticity**  
  Automatic scaling of resources up or down as workload changes.

- **High Availability**  
  Ensures minimal downtime by distributing services across multiple systems.

- **Agility**  
  Rapid provisioning of resources to respond quickly to business needs.

- **Fault Tolerance**  
  Capability of systems to continue operating even when components fail.

- **Disaster Recovery**  
  Ability to recover data and applications after unexpected events.

- **Consumption-Based Model (Pay-as-You-Go)**  
  Users pay only for the resources they consume.


## Cloud Service Models


![Cloud Service Model by Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/1hitz6c7p1ocaezjyd05.png)

### Infrastructure as a Service (IaaS)

- Most responsibility lies with the **consumer**.
- The provider manages networking, storage, servers, and virtualization.
- Common use cases:
  - Test and development
  - Lift-and-shift migration
  - Virtual machines
- Examples:
  - Azure Virtual Machines
  - AWS EC2


### Platform as a Service (PaaS)

- Responsibilities are **shared** between provider and consumer.
- The provider manages OS, runtime, middleware, and infrastructure.
- The consumer focuses on application code and data.
- Use cases:
  - Application development frameworks
- Example:
  - Heroku


### Software as a Service (SaaS)

- Most responsibility lies with the **provider**.
- Users access applications directly over the internet.
- Examples:
  - Gmail
  - Outlook
  - OneDrive
  - Microsoft 365


## Shared Responsibility Model

The shared responsibility model defines how security and management responsibilities are divided between the cloud provider and the customer.

- The cloud provider is responsible for securing the **cloud infrastructure**.
- The customer is responsible for securing **data, access, and configurations**, depending on the service model.


## Cloud Deployment Models


![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/jpv87rlbgbdvbmp09z4v.png)


### Private Cloud
- Offers greater control and security.
- Higher cost and requires skilled technical teams.

### Public Cloud
- Fully owned and managed by the cloud provider.
- No large initial investment.

### Hybrid Cloud
- Combination of private and public clouds.
- Sensitive workloads remain in private clouds while leveraging public cloud flexibility.

### Multi-Cloud
- Uses multiple cloud providers.
- Leverages different services and features from different clouds.


## API (Application Programming Interface)

An API is a set of rules that allows software applications to communicate with each other.

In cloud computing, APIs provide a programmatic way to interact with cloud services such as:
- Compute
- Storage
- Databases
- Artificial Intelligence services


## Scaling in Cloud Computing

### Vertical Scaling
- Increasing or decreasing the capacity of a resource.
- Example: Adding more CPU or RAM to a virtual machine.

### Horizontal Scaling
- Adding or removing multiple instances of resources.
- Commonly used in high-traffic applications.


## Virtualization

Virtualization is the process of creating virtual versions of physical resources such as servers, operating systems, storage, and networks.

Key points:
- Enables running multiple operating systems on a single physical machine.
- Improves resource utilization by logically dividing servers.
- Allows OSs like Windows and Linux to run on the same hardware.


## Hypervisor

A hypervisor enables virtualization by:
- Simulating complete machines with their own operating systems.
- Isolating multiple virtual machines on a single physical host.
- Allowing multiple OSs to run independently on the same hardware.


## Containerization

Containerization is a lightweight alternative to virtualization and is best suited for microservices architectures.

Key characteristics:
- Containers package applications with all required dependencies.
- They share the host OS kernel.
- No separate OS is required for each container.
- Solves the “works on my machine” problem.

Containers are ideal for scenarios such as:
- Full-stack applications with high backend load
- Microservices-based architectures

Note: Containers cannot run a completely different operating system since they rely on the host OS kernel.


## Datacenters, Regions, and Availability Zones

### Datacenter
A physical facility that houses servers, storage, and networking equipment.

### Region
A geographical area containing multiple datacenters to ensure resiliency and reliability for business-critical workloads.

### Availability Zones (Azure)
- Physically separate datacenters within a region.
- Azure regions contain a minimum of three availability zones.
- If one zone fails, the others continue operating.


## Azure-Specific Concepts

### Management Groups
- Used to organize subscriptions.
- Apply policies, permissions, and restrictions at scale.

### Azure Virtual Machines
- Provide Infrastructure as a Service (IaaS).

### VM Scale Sets
- Centrally manage and scale large numbers of identical virtual machines.

### Availability Sets
- Improve application uptime by distributing VMs across fault and update domains.


## Virtual Machines vs Containers

![Omkar Sharma](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/b5w0esojhad9ea0o03iq.png)

### Virtual Machines
- Reduce cost compared to physical hardware.
- Each VM runs a single operating system.
- Heavier than containers due to OS overhead.

### Containers
- Lightweight and fast.
- Allow multiple application instances on a single host.
- Package all application dependencies.
- Remove OS-level dependency issues.


## Summary

Cloud computing enables organizations to build, deploy, and scale applications efficiently by providing computing resources as services. It offers scalability, flexibility, high availability, and cost efficiency while eliminating the need for heavy upfront infrastructure investments.

---

✍️ **Author**: *Omkar Sharma*  
📬 *Feel free to connect on [LinkedIn](https://www.linkedin.com/in/omkarsharmaa/) or explore more on [GitHub](https://github.com/omkarsharma2821)* 