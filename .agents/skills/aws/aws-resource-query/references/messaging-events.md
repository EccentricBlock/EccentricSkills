### MESSAGING & EVENTS

```bash
# "SQS queues" / "list queues"
aws sqs list-queues --query 'QueueUrls' --output table

# "SQS queue details / message count for <url>"
aws sqs get-queue-attributes --queue-url <url> \
  --attribute-names ApproximateNumberOfMessages,ApproximateNumberOfMessagesNotVisible,ApproximateAgeOfOldestMessage

# "SNS topics"
aws sns list-topics --query 'Topics[].TopicArn' --output table

# "SNS subscriptions"
aws sns list-subscriptions \
  --query 'Subscriptions[].[SubscriptionArn,Protocol,Endpoint,TopicArn]' --output table

# "EventBridge rules"
aws events list-rules \
  --query 'Rules[].[Name,State,ScheduleExpression,EventPattern]' --output table

# "EventBridge event buses"
aws events list-event-buses \
  --query 'EventBuses[].[Name,Arn]' --output table

# "Kinesis streams"
aws kinesis list-streams --query 'StreamNames' --output table

# "Kinesis Firehose delivery streams"
aws firehose list-delivery-streams --query 'DeliveryStreamNames' --output table
```

---
