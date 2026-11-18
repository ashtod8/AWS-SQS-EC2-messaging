# AWS-SQS-EC2-messaging
A hands-on AWS SQS project implementing message queuing with EC2-based producer and consumer scripts

## Overview

This project demonstrates message communication between two Amazon EC2 instances using Amazon Simple Queue Service (SQS).

One EC2 instance acts as a **Producer**, sending messages to an SQS queue. The other EC2 instance acts as a **Consumer**, retrieving messages from the queue, processing them, and deleting them after successful retrieval.

The project uses AWS CLI and Bash scripts to automate message transmission and consumption.

## Architecture

```text
Producer EC2 Instance
        |
        | Send messages
        v
   Amazon SQS Queue
        |
        | Receive messages
        v
Consumer EC2 Instance
        |
        | Delete processed messages
        v
  Message removed from queue
```

## Technologies Used

- Amazon EC2
- Amazon SQS
- AWS IAM Roles
- AWS CLI
- Linux (Amazon Linux)
- Bash scripting

## Prerequisites

- AWS account
- Two Amazon Linux EC2 instances
  - Producer instance
  - Consumer instance
- IAM role attached to both EC2 instances with SQS permissions
- AWS CLI installed
- `jq` installed on the Consumer instance

## Step 1: Create an SQS Queue

Create a queue named `MyTestQueue` using AWS CLI.

```bash
aws sqs create-queue --queue-name Queue1
```

Retrieve the queue URL:

```bash
aws sqs get-queue-url --queue-name Queue1
```

The queue URL is used by the Producer and Consumer scripts to interact with SQS.

## Step 2: Create an IAM Role

Create an IAM role to allow EC2 instances to access Amazon SQS without requiring manually configured AWS credentials.

Navigate to IAM → Roles.

Click Create role.

Select AWS service as the trusted entity type.

Select EC2 as the use case.

Click Next.

Search for and attach the AmazonSQSFullAccess policy.

Click Next.

Set the role name to EC2SQSRole.

Review the configuration and click Create role.

This role allows EC2 instances to interact with SQS.

## Step 3: Configure EC2 Instances

Launch two Amazon Linux EC2 instances:

- **Producer EC2** – Sends messages to the SQS queue.
- **Consumer EC2** – Receives and deletes messages from the SQS queue.

Attach an IAM role with the necessary SQS permissions to both instances.

AWS CLI is preinstalled on Amazon Linux instances. Install `jq` on the Consumer instance if it is not already available.

## Step 4: Configure the Producer

Connect to the Producer EC2 instance.

Create the producer script using the Nano text editor:

```bash
nano send-message.sh
```

Enter the producer script, save the file, and exit Nano.

Make the script executable:

```bash
chmod +x sqs-producer.sh
```

Execute the script:

```bash
./send-message.sh
```

The Producer script sends five messages to the SQS queue.

## Step 5: Configure the Consumer

Connect to the Consumer EC2 instance.

Create the consumer script using Nano:

```bash
nano receive-message.sh
```

Enter the consumer script, save the file, and exit Nano.

Make the script executable:

```bash
chmod +x sqs-consumer.sh
```

Execute the script:

```bash
./receive-message.sh
```

The Consumer continuously polls the queue, receives messages, and deletes them after retrieval.

## Step 6: Testing

1. Connect to the Producer EC2 instance.
2. Execute the producer script to send messages to the queue.
3. Connect to the Consumer EC2 instance.
4. Execute the consumer script.
5. Observe the received messages in the terminal.
6. Verify that messages are deleted from the queue after processing.

## Expected Output

### Producer

```text
Sent message 1
Sent message 2
Sent message 3
Sent message 4
Sent message 5
```

### Consumer

```text
Received message
Message deleted
```

The Consumer continues running and waits for additional messages.

## Learning Outcomes

- Understanding Amazon SQS message queuing
- Implementing Producer–Consumer architecture
- Sending and receiving messages using AWS CLI
- Using IAM roles for EC2 access to AWS services
- Automating AWS tasks using Bash scripts
- Managing message deletion after consumption

## Conclusion

This project demonstrates asynchronous communication between EC2 instances using Amazon SQS. The Producer sends messages to a queue, while the Consumer retrieves and deletes them, demonstrating a simple cloud-based message-processing workflow.
monstrating a simple cloud-based message-processing workflow.
