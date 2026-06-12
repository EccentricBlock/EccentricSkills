### COMPUTE

#### EC2 Instances
```bash
# "list EC2 instances" / "show my VMs" / "what instances are running"
aws ec2 describe-instances \
  --query 'Reservations[].Instances[].[InstanceId,InstanceType,State.Name,Tags[?Key==`Name`].Value|[0],PrivateIpAddress,PublicIpAddress]' \
  --output table

# "running instances only"
aws ec2 describe-instances --filters Name=instance-state-name,Values=running \
  --query 'Reservations[].Instances[].[InstanceId,InstanceType,Tags[?Key==`Name`].Value|[0],PrivateIpAddress]' \
  --output table

# "stopped instances"
aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped \
  --query 'Reservations[].Instances[].[InstanceId,InstanceType,Tags[?Key==`Name`].Value|[0]]' \
  --output table

# "instance types in use"
aws ec2 describe-instances --query 'Reservations[].Instances[].InstanceType' --output text | sort | uniq -c | sort -rn

# "auto scaling groups" / "ASGs"
aws autoscaling describe-auto-scaling-groups \
  --query 'AutoScalingGroups[].[AutoScalingGroupName,MinSize,MaxSize,DesiredCapacity]' --output table

# "elastic IPs" / "EIPs"
aws ec2 describe-addresses \
  --query 'Addresses[].[PublicIp,InstanceId,AllocationId,AssociationId]' --output table

# "key pairs"
aws ec2 describe-key-pairs \
  --query 'KeyPairs[].[KeyName,CreateTime]' --output table

# "AMIs I own"
aws ec2 describe-images --owners self \
  --query 'Images[].[ImageId,Name,CreationDate,State]' --output table

# "spot instances"
aws ec2 describe-spot-instance-requests \
  --query 'SpotInstanceRequests[].[SpotInstanceRequestId,State,InstanceId,LaunchSpecification.InstanceType]' --output table
```

#### Lambda Functions
```bash
# "list Lambda functions" / "show serverless functions"
aws lambda list-functions \
  --query 'Functions[].[FunctionName,Runtime,MemorySize,Timeout,LastModified]' --output table

# "Lambda function details for <name>"
aws lambda get-function-configuration --function-name <name>

# "Lambda event source mappings" / "Lambda triggers"
aws lambda list-event-source-mappings \
  --query 'EventSourceMappings[].[FunctionArn,EventSourceArn,State,BatchSize]' --output table

# "Lambda layers"
aws lambda list-layers \
  --query 'Layers[].[LayerName,LatestMatchingVersion.LayerVersionArn]' --output table

# "Lambda concurrency for <name>"
aws lambda get-function-concurrency --function-name <name>
```

#### ECS
```bash
# "ECS clusters"
aws ecs list-clusters --query 'clusterArns' --output table

# "ECS cluster details"
aws ecs describe-clusters \
  --clusters $(aws ecs list-clusters --query 'clusterArns[]' --output text) \
  --query 'clusters[].[clusterName,status,runningTasksCount,activeServicesCount]' --output table

# "ECS services in <cluster>"
aws ecs describe-services --cluster <cluster> \
  --services $(aws ecs list-services --cluster <cluster> --query 'serviceArns[]' --output text) \
  --query 'services[].[serviceName,status,runningCount,desiredCount]' --output table

# "ECS task definitions"
aws ecs list-task-definitions --query 'taskDefinitionArns' --output table
```

#### EKS
```bash
# "EKS clusters" / "Kubernetes clusters"
aws eks list-clusters --query 'clusters' --output table

# "EKS cluster details for <name>"
aws eks describe-cluster --name <name> \
  --query 'cluster.[name,status,version,endpoint]'

# "EKS node groups for <cluster>"
aws eks list-nodegroups --cluster-name <name> --query 'nodegroups' --output table

# "EKS add-ons for <cluster>"
aws eks list-addons --cluster-name <name> --query 'addons' --output table
```

#### Other Compute
```bash
# "Beanstalk environments"
aws elasticbeanstalk describe-environments \
  --query 'Environments[].[EnvironmentName,ApplicationName,Status,Health]' --output table

# "Batch job queues"
aws batch describe-job-queues \
  --query 'jobQueues[].[jobQueueName,state,status,priority]' --output table

# "Batch compute environments"
aws batch describe-compute-environments \
  --query 'computeEnvironments[].[computeEnvironmentName,type,state,status]' --output table
```

---
