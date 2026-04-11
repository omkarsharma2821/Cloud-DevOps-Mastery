# Jenkins Controller-Agent/Master-Slave Architecture: Setup Agents, Benefits, and Disadvantages Explained

In Jenkins, **master-slave architecture** (now often called **controller-agent architecture**) is used to distribute work and scale automation efficiently.

The **controller (master)** is the main Jenkins server where Jenkins is installed. It is also referred to as the **built-in node**.  
The **agent node (slave/worker)** is a separate machine where builds are executed, and it only requires a Java environment to run.

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/hf4rc42g413pvbec2xbs.png)

## Why do we need this architecture?

A single node (master/controller server) can become overloaded if it:
- runs all builds  
- manages jobs  
- handles UI and scheduling  

To overcome this, responsibilities are divided:

- **Master (Controller)** → manages jobs, UI, and scheduling  
- **Slaves (Agents)** → execute builds  

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/upymri9xjo6ekb0mjaij.png)

This separation improves performance, scalability, and flexibility.


## Disadvantages

### 1. **Complex Setup**
- Requires configuration of agents, SSH, and security.
- More complex compared to a single Jenkins server.

### 2. **Maintenance Overhead**
- Multiple machines need to be managed.
- Requires updates, monitoring, and troubleshooting.

### 3. **Network Dependency**
- Agents communicate with the master over a network.
- Network issues can cause build failures or delays.

### 4. **Security Concerns**
- More nodes increase the attack surface.
- Proper authentication and access control are required.

### 5. **Debugging is Harder**
- Issues may occur on specific agents.
- Debugging is more difficult compared to a single-node setup.