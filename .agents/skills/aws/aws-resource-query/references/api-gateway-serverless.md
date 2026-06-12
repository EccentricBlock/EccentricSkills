### API GATEWAY & SERVERLESS

```bash
# "API Gateway APIs" / "REST APIs"
aws apigateway get-rest-apis \
  --query 'items[].[id,name,description,createdDate]' --output table

# "HTTP APIs" / "API Gateway v2"
aws apigatewayv2 get-apis \
  --query 'Items[].[ApiId,Name,ProtocolType,ApiEndpoint,CreatedDate]' --output table

# "Step Functions state machines" / "workflows"
aws stepfunctions list-state-machines \
  --query 'stateMachines[].[name,stateMachineArn,type,creationDate]' --output table

# "Step Functions executions for <arn>"
aws stepfunctions list-executions --state-machine-arn <arn> \
  --query 'executions[].[name,status,startDate,stopDate]' --output table
```

---
