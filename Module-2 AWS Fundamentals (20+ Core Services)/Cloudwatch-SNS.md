## Successfully Configuring an AWS EC2 CPU Alert at 60%: A Hands-On Case Study

It started with a simple goal: create an EC2 instance, push its CPU
utilization above 60%, and receive an email alert from AWS.

Sounds straightforward, right?

Launch an instance. Install a stress utility. Create a CloudWatch alarm.
Connect the alarm to an SNS topic. Generate CPU load—and wait for the
email.

I completed the activity successfully. The CPU workload, CloudWatch
alarm, and SNS email notification came together to demonstrate a
practical monitoring workflow. Along the way, I also explored how to
observe CPU behavior on a burstable EC2 instance and validate the alarm
configuration.

In this conversational case study, I’ll walk through the setup, the
commands I used, and the key takeaways from the lab.

------------------------------------------------------------------------

## The objective

The goal was to build a small monitoring workflow:

1.  Launch an Ubuntu EC2 instance.
2.  Generate CPU load on the instance.
3.  Monitor `CPUUtilization` using Amazon CloudWatch.
4.  Configure an alarm for CPU utilization greater than 60%.
5.  Send an email notification through Amazon SNS when the alarm enters
    the `ALARM` state.

The architecture is intentionally simple:

![omkarsharma2821](https://dev-to-uploads.s3.us-east-2.amazonaws.com/uploads/articles/re0moqp8zceheh0xc1oh.png)

## The environment

For this activity, I used the following setup:

  Component              Configuration
  ---------------------- ----------------------------------
  Cloud provider         AWS
  Region                 `ap-south-1` (Mumbai)
  Operating system       Ubuntu
  EC2 instance type      `t3.micro`
  vCPUs                  2
  Memory                 1 GiB
  Monitoring service     Amazon CloudWatch
  Notification service   Amazon SNS
  Alarm threshold        CPU utilization greater than 60%
  Workload utility       `stress`

> **Note:** The region listed here is the activity's working region.
> Make sure your EC2 instance, CloudWatch metric, alarm, and SNS topic
> are in the appropriate regions for your setup.

## Step 1: Launch the EC2 instance

I launched an Ubuntu EC2 instance using the `t3.micro` instance type.

A `t3.micro` provides 2 vCPUs and 1 GiB of memory.

## Step 2: Install the stress utility

To generate CPU load, I installed the `stress` utility on Ubuntu:

``` bash
sudo apt update
sudo apt install stress -y
```

I checked the number of CPUs available to the operating system:

``` bash
nproc
```

The command reported 2 CPUs.

![omkarsharma2821](https://dev-to-uploads.s3.us-east-2.amazonaws.com/uploads/articles/6xnglxkwuwct76klkz1f.png)

For this test, I planned to use two CPU workers---one per vCPU.

## Step 3: Create the CPU stress script

Rather than repeatedly typing the command, I created a small Bash script
named `cpu-stress.sh`.

``` bash
#!/bin/bash

# EC2 CPU Stress Test
CPU=$(nproc)
DURATION=900

echo "======================================"
echo "      EC2 CPU STRESS TEST"
echo "======================================"
echo "Available vCPUs : $CPU"
echo "CPU Workers     : $CPU"
echo "Duration        : $DURATION seconds"
echo "Target          : High CPU utilization"
echo "======================================"

if ! command -v stress >/dev/null 2>&1; then
    echo "ERROR: stress is not installed."
    exit 1
fi

echo "Starting CPU workload..."

stress --cpu "$CPU" --timeout "$DURATION" --verbose

echo "CPU stress completed."
```

The important values are:

-   `CPU=$(nproc)` automatically detects the available CPUs.
-   `DURATION=900` sets the workload duration to 900 seconds, or 15
    minutes.
-   `stress --cpu "$CPU"` starts CPU workers based on the CPU count.

I made the script executable:

``` bash
chmod +x cpu-stress.sh
```

Then I launched it in the background:

``` bash
nohup ./cpu-stress.sh > cpu-stress.log 2>&1 &
```

Using `nohup` allowed the workload to continue even if I disconnected
from the SSH session.

To monitor the script's output:

``` bash
tail -f cpu-stress.log
```

![omkarsharma2821](https://dev-to-uploads.s3.us-east-2.amazonaws.com/uploads/articles/atnaro7p67kypst7p625.png)

To verify the processes:

``` bash
pgrep -af 'cpu-stress|stress'
```

## Step 4: Configure Amazon SNS email notifications

Next, I created an SNS topic named:

``` text
EC2-CPU-Alert
```

![omkarsharma2821](https://dev-to-uploads.s3.us-east-2.amazonaws.com/uploads/articles/mm2ub2fpwg7yxwlvor07.png)

I added an email subscription using my email address.

One important step: I opened the confirmation email from AWS and
confirmed the subscription.

Until the email subscription is confirmed, SNS cannot deliver
notifications to that address.

## Step 5: Configure the CloudWatch alarm

I created a CloudWatch alarm using the EC2 metric:

``` text
CPUUtilization
```

The alarm configuration was:

  Setting              Value
  -------------------- ---------------------------
  Metric               EC2 `CPUUtilization`
  Statistic            Average
  Period               1 minute (60 seconds)
  Threshold            Greater than 60%
  Evaluation           1 out of 1 datapoints
  Alarm action         SNS topic `EC2-CPU-Alert`
  Notification state   `ALARM`

The alarm logic was simple:

``` text
IF Average CPUUtilization > 60%
FOR the configured evaluation period
THEN enter ALARM state
AND send an SNS email notification
```

![omkarsharma2821](https://dev-to-uploads.s3.us-east-2.amazonaws.com/uploads/articles/1b4fhacacs1zp9aabie2.png)

![omkarsharma2821](https://dev-to-uploads.s3.us-east-2.amazonaws.com/uploads/articles/6lfqdvoezpvao7cn48sl.png)

CloudWatch alarms evaluate metric datapoints. They do not continuously
send an email for every datapoint while the alarm remains in the same
`ALARM` state. Notifications are generally triggered by a state
transition.

## Step 6: Generate CPU load and observe the instance

With the workload script running, I monitored the instance from the
terminal and checked the stress processes:

```bash
pgrep -af 'cpu-stress|stress'
```

I also used `top` to observe CPU activity in the guest operating system:

```bash
top -b -n 1 | head -15
```

![omkarsharma2821](https://dev-to-uploads.s3.us-east-2.amazonaws.com/uploads/articles/qepb06npiwjhlaqx02sn.png)

## Step 7: Validate the CloudWatch alarm and SNS notification

I validated the monitoring flow by reviewing the alarm configuration
and its state. These are the key checks I used to ensure the setup was
properly connected:

-   Is the CloudWatch graph using the correct EC2 instance ID?
-   Is the graph in the same AWS region as the instance?
-   Is the alarm using the `CPUUtilization` metric?
-   Is the statistic set to `Average` and the period set to 60 seconds?
-   Is the alarm threshold configured as `Greater than 60`?
-   Is the alarm's evaluation window aligned with the period of the
    stress test?
-   Is the SNS email subscription confirmed?
-   What does the alarm's **History** tab show?

A CloudWatch graph can show historical metric values, while the alarm
state reflects its latest evaluation. The Alarm History tab is helpful
for reviewing state transitions. Once the alarm enters `ALARM`, the
configured SNS action sends the notification to the confirmed email
subscription.

**The activity outcome:** the CPU monitoring workflow was completed
successfully, with the CloudWatch alarm and SNS email notification
working as intended.


## Clean up after the test

A CPU stress test should not be left running unnecessarily.

To stop the `stress` processes:

``` bash
sudo pkill -x stress
```

Verify that they have stopped:

``` bash
pgrep -a stress
```

If the command returns no output, no `stress` process is running.

------------------------------------------------------------------------

### Services and tools used

-   Amazon EC2
-   Amazon CloudWatch
-   Amazon SNS
-   Ubuntu Linux
-   Bash
-   `stress`

---

✍️ **Author**: *Omkar Sharma*  
📬 *Feel free to connect on [LinkedIn](https://www.linkedin.com/in/omkarsharmaa/) or explore more on [GitHub](https://github.com/omkarsharma2821)*