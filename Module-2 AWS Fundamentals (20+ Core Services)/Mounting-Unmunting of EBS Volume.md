# Mounting and Making EBS Volume Persistent on EC2: Step-by-Step Guide

## 🔧 Step 1: Create an EBS Volume

1. Go to the **EC2 Dashboard** in AWS Console.
2. In the left panel, click **Elastic Block Store > Volumes**.
3. Click **Create Volume**.
4. Fill in:
   - **Size** (e.g., 10 GiB)
   - **Availability Zone** (Must match your EC2 instance)
   - Leave other options default
5. Click **Create Volume**.

![omkarsharma2821](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/xvczj4kdd55lpg6x2kct.png)

## 🔗 Step 2: Attach Volume to EC2 Instance

1. Select the newly created volume.
2. Click **Actions > Attach Volume**.
3. Choose your instance and device name (e.g., `/dev/xvdf`).
4. Click **Attach**.

![omkarsharma2821](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/6wuiw1zcx9oofl40xo0o.png)

![omkarsharma2821](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/gssrx39796dvxywh4ks7.png)

![omkarsharma2821](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/bqbpqswsbewpgx5vpu6j.png)

![omkarsharma2821](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/i1qgncaqqppdfuyhpjc9.png)

The volume status changes from `Available` ➝ `In-use`.

## 🧪 Step 3: Verify the Volume is Attached

```bash
lsblk
```
Output will show `/dev/xvdf` (or similar) listed without a mountpoint.

![omkarsharma2821](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/syc3vebc8nbki26flvyd.png)

## 🧱 Step 4: Format the Volume with ext4

```bash
sudo mkfs -t ext4 /dev/xvdf
or
sudo mkfs.ext4 /dev/xvdf
```

![omkarsharma2821](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/fdinkr2hcaoyd0zpflrb.png)

## ❓ Why Do We Format the Volume?

When you create a new EBS volume, it's like a brand-new hard drive — **it has no filesystem**. Formatting it is essential because:

- It defines **how data is stored and organized**.
- It prepares the volume to **store files and directories**.
- It enables the system to **mount and use the volume**.

> ⚠️ Without formatting, the volume cannot be used to store any data.

## 📂 Step 5: Create a Mount Directory

```shell
sudo su : to swtich to super user
cd / : to go to home directory
mkdir /your-dir-name : to create new directory
```
> [Learn Linux commands from scratch](https://github.com/omkarsharma2821/Linux-Ultimate-Cheat-Sheet)

![omkarsharma2821](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/8c2q5iclxo4hmfqgp5fe.png)

| Basis                     | `mkdir /test`                                                        | `mkdir test`                                                  |
| ------------------------- | -------------------------------------------------------------------- | ------------------------------------------------------------- |
| Path type                 | Absolute path                                                        | Relative path                                                 |
| Location                  | Creates `test` in the root directory (`/`).                          | Creates `test` in the current working directory.              |
| Starting point            | Starts from `/` (root).                                              | Starts from the current directory.                            |
| Example current directory | `/home/ubuntu`                                                       | `/home/ubuntu`                                                |
| Result                    | `/test`                                                              | `/home/ubuntu/test`                                           |
| Permission                | May require `sudo`.                                                  | Usually requires write permission in the current directory.   |
| Use case                  | When you want to create a directory at a specific absolute location. | When you want to create a directory in your current location. |

Easy trick to remember:

- `/test` → Root directory.
- `test` → Current directory.

Example:

```shell
pwd
# Output: /home/ubuntu

mkdir test
# Creates /home/ubuntu/test

mkdir /test
# Creates /test
```

## 📌 Step 6: Mount the Volume

```bash
mount /dev/xvdf /test
```

![omkarsharma2821](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/gma6i6zwlekofuagkinz.png)

if not want to mount at /

![omkarsharma2821](https://dev-to-uploads.s3.us-east-2.amazonaws.com/uploads/articles/eb951jvsqchjyk2s62b1.png)

Verify the mount:

```bash
df -h
```
## 🔁 Step 7: Make the Mount Persistent (After Reboot)

To make the mount persistent, add an entry to `/etc/fstab`.

1. First, get the UUID:

```bash
blkid
```

![omkarsharma2821](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/fosz9odybcokn5ipfl8j.png)

2. Open the fstab file:

```bash
if vi /etc/fstab
```

```plaintext
Note:
press "i" to insert mode
press "esc" to return 
press ":wq!" to write and exit
```

![omkarsharma2821](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/28ki5s995hhx6gbhafj3.png)


## 🔄 Step 8: Reboot and Verify

```bash
reboot
```

After reboot, connect again and run:

```bash
df -h
```

You should see `/test` mounted. ✅

To increase the size of the same EBS volume, you must first modify the volume from the AWS Management Console (AWS Portal) and then extend the partition and file system inside the EC2 instance, if required.

```bash
sudo resize2fs /dev/nvme1n1
```

![omkarsharma2821](https://dev-to-uploads.s3.us-east-2.amazonaws.com/uploads/articles/agp7peqp3gz2rt9g7jxd.png)


## 🧹 Optional: Test Persistence

You can unmount and remount to test:

```bash
umount /test
mount -a
df -h
```
```bash
mount -a
```
- Reads the file /etc/fstab.
- Mounts all configured file systems that are not currently mounted and are eligible for automatic mounting.
- Commonly used to test /etc/fstab entries without rebooting the server.