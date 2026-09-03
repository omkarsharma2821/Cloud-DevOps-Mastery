# Terraform Providers: What Actually Happens Behind the Scenes?

![omkarsharma2821](https://dev-to-uploads.s3.us-east-2.amazonaws.com/uploads/articles/0r316n0o9lzl4gwadcsw.png)


Whenever we create a resource using the AWS Console or AWS CLI, we are indirectly interacting with the APIs of AWS services.

For example, when we create an EC2 instance from the AWS Console, the console is making API requests to the AWS EC2 service behind the scenes. The same thing happens when we use the AWS CLI — our commands eventually result in API calls to AWS.

So, what happens when we use Terraform to provision resources in the cloud?

This is where **Terraform Providers** come into the picture.

When we write our infrastructure code using **HashiCorp Configuration Language (HCL)** in `.tf` files, Terraform uses providers to interact with the APIs of the platform we want to manage.

A Terraform provider acts as a **plugin and a bridge between Terraform and the platform's APIs**.

For example, when we use the AWS provider, Terraform can use that provider to communicate with AWS APIs and manage resources such as EC2, S3, VPC, IAM, and many others.

So, if we simplify what is happening behind the scenes:

```text
Terraform Code (.tf)
        ↓
     Terraform
        ↓
  Terraform Provider
        ↓
      AWS APIs
        ↓
   AWS Resources
```

The important thing to remember is:

> **Terraform defines what we want, while the provider knows how to communicate with the platform to manage those resources.**


### Importance of version constraints and Version Locking in Terraforma and providers versions

| Operator | Example     | Allows                     | Meaning                   |
| -------- | ----------- | -------------------------- | ------------------------- |
| `=`      | `= 6.62.0`  | `6.62.0` only              | Exact version             |
| `!=`     | `!= 6.62.0` | Everything except `6.62.0` | Exclude a version         |
| `>`      | `> 6.62.0`  | `6.62.1`, `6.63.0`, etc.   | Greater than              |
| `>=`     | `>= 6.62.0` | `6.62.0` and newer         | Greater than or equal     |
| `<`      | `< 6.62.0`  | Versions below `6.62.0`    | Less than                 |
| `<=`     | `<= 6.62.0` | `6.62.0` and older         | Less than or equal        |
| `~>`     | `~> 6.62.0` | `6.62.x`                   | Allow patch updates       |
| `~>`     | `~> 6.62`   | `6.x`                      | Allow minor/patch updates |
