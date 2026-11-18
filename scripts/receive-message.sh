#!/bin/bash
	QUEUE_URL=$(aws sqs get-queue-url --queue-name DemoQueue --query "QueueUrl" --output text)
	while true
	do
  		MESSAGES=$(aws sqs receive-message --queue-url $QUEUE_URL --max-number-of-messages 1)
  		if [ -z "$MESSAGES" ]; then
    		echo "No messages, waiting..."
    		sleep 5
  		else
    		echo "Received: $MESSAGES"
    		RECEIPT=$(echo $MESSAGES | jq -r '.Messages[0].ReceiptHandle')
    		aws sqs delete-message --queue-url $QUEUE_URL --receipt-handle "$RECEIPT"
    		echo "Message deleted"
  		fi
	done
