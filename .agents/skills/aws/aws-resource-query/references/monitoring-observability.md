### MONITORING & OBSERVABILITY

```bash
# "CloudWatch alarms" / "list alarms"
aws cloudwatch describe-alarms \
  --query 'MetricAlarms[].[AlarmName,StateValue,MetricName,Namespace,Threshold]' --output table

# "alarms in ALARM state" / "triggered alarms"
aws cloudwatch describe-alarms --state-value ALARM \
  --query 'MetricAlarms[].[AlarmName,MetricName,StateReason]' --output table

# "CloudWatch dashboards"
aws cloudwatch list-dashboards \
  --query 'DashboardEntries[].[DashboardName,LastModified,Size]' --output table

# "CloudWatch log groups"
aws logs describe-log-groups \
  --query 'logGroups[].[logGroupName,retentionInDays,storedBytes]' --output table

# "CloudTrail trails"
aws cloudtrail describe-trails \
  --query 'trailList[].[Name,S3BucketName,IsMultiRegionTrail,LogFileValidationEnabled]' --output table

# "ECR repositories" / "container registries"
aws ecr describe-repositories \
  --query 'repositories[].[repositoryName,repositoryUri,createdAt]' --output table
```

---
