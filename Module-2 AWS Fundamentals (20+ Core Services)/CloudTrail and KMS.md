# AWS CloudTrail and AWS KMS

## AWS CloudTrail

### What it is
CloudTrail is an **auditing and governance service** that records API calls and account activity across your AWS account. Every time someone (or something) interacts with AWS, whether through the Console, CLI, SDK, or another AWS service, CloudTrail can log it.

### What each event records
- **Who** made the call (IAM user, role, root, or AWS service)
- **What** action was performed (e.g., `RunInstances`, `DeleteBucket`, `PutObject`)
- **When** it happened (timestamp)
- **Where** it came from (source IP address, user agent)
- **Which resources** were affected
- **Result** (success or error code)

### Types of events

| Event type | What it covers | Logged by default? |
|---|---|---|
| **Management events** | Control-plane operations: creating EC2 instances, changing IAM policies, modifying security groups | Yes (last 90 days in Event History) |
| **Data events** | Data-plane operations: S3 object-level actions (`GetObject`, `PutObject`), Lambda invocations, DynamoDB item-level actions | No (must be enabled, extra cost) |
| **Insights events** | Detects unusual activity, like a sudden spike in API calls or error rates | No (must be enabled) |
| **Network activity events** | Records VPC endpoint activity | No |

### Key concepts

**Event History**: Automatically available for 90 days of management events, with no setup. Good for quick lookups, but not for long-term retention.

**Trail**: A configuration you create to deliver events to an **S3 bucket** (and optionally CloudWatch Logs or EventBridge) for long-term storage. Trails can be:
- **Single-region** or **multi-region** (multi-region is recommended)
- **Organization trails**, which log all accounts in an AWS Organization from one place

**CloudTrail Lake**: A managed data store where you can run **SQL queries** directly on your events, without building your own pipeline with Athena.

**Log file integrity validation**: CloudTrail creates digitally signed digest files so you can prove logs weren't tampered with after delivery.

### Common use cases
- **Security investigation**: "Who deleted that S3 bucket?"
- **Compliance and auditing**: Evidence for Puposes etc.
- **Troubleshooting**: Finding which change broke something
- **Alerting**: Combine with CloudWatch/EventBridge to alert on events like root account login or security group changes

---

## AWS KMS (Key Management Service)

### What it is
KMS is a **managed service for creating and controlling cryptographic keys** used to encrypt your data. It integrates with most AWS services (S3, EBS, RDS, DynamoDB, Lambda, Secrets Manager, etc.) so you can encrypt data without managing the cryptography yourself.

KMS keys are protected inside **FIPS 140-validated hardware security modules (HSMs)**, and the key material never leaves KMS in plaintext.

### Types of KMS keys

| Key type | Who manages it | Notes |
|---|---|---|
| **AWS owned keys** | AWS | Used internally by some services; you can't see or control them; free |
| **AWS managed keys** (e.g., `aws/s3`) | AWS creates them in your account | You can view usage but not manage rotation or policies; rotated automatically |
| **Customer managed keys (CMKs)** | You | Full control over policies, rotation, enabling/disabling, deletion; small monthly fee plus per-request cost |

KMS also supports **symmetric keys** (one key encrypts and decrypts, AES-256-GCM; most common) and **asymmetric keys** (public/private key pairs, used for signing or encryption outside AWS).

### Access control
Access to a KMS key requires permission from **both**:
- **Key policy**: The primary, resource-based policy attached to the key (required for every key)
- **IAM policies**: Can grant access only if the key policy allows it
- **Grants**: Temporary, delegated permissions, often used by AWS services

### Key features
- **Automatic key rotation**: Optional yearly rotation for customer managed keys (the key ID stays the same; old key material is retained to decrypt older data)
- **Key aliases**: Friendly names like `alias/my-app-key`
- **Multi-Region keys**: Same key material across regions, useful for disaster recovery and global applications
- **Deletion safety**: Keys have a mandatory **7–30 day waiting period** before deletion, because deleting a key makes all data encrypted with it permanently unrecoverable
- **Custom key stores**: Back your keys with your own CloudHSM cluster for stricter compliance

### Common use cases
- Encrypting S3 buckets (SSE-KMS), EBS volumes, RDS databases
- Encrypting secrets and environment variables
- Digital signing and verification
- Meeting regulatory requirements for key control


### Quick analogy
- **KMS** is the **lock and key** on your valuables.
- **CloudTrail** is the **security camera log** recording every time someone touches a lock or opens the door.

---

## Quick comparison

| | CloudTrail | KMS |
|---|---|---|
| **Purpose** | Audit and governance | Encryption key management |
| **Question answered** | Who did what, when? | How is my data encrypted and who can decrypt it? |
| **Category** | Security/monitoring | Security/data protection |
| **Output** | Log files, queryable events | Encrypted data, managed keys |
| **Pricing basics** | First management-event trail free; data events and extra trails cost | Per key per month plus per API request |