#!/bin/bash
	QUEUE_URL=$(aws sqs get-queue-url --queue-name DemoQueue --query "QueueUrl" --output text)
	for i in {1..5}
	do
  		aws sqs send-message --queue-url $QUEUE_URL --message-body "Hello from Producer - $i"
  		echo "Sent message $i"
	done
