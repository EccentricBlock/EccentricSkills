### DATABASES

#### RDS
```bash
# "list RDS instances" / "show databases" / "what databases do I have"
aws rds describe-db-instances \
  --query 'DBInstances[].[DBInstanceIdentifier,DBInstanceClass,Engine,EngineVersion,DBInstanceStatus,MultiAZ,Endpoint.Address]' \
  --output table

# "Aurora clusters" / "RDS clusters"
aws rds describe-db-clusters \
  --query 'DBClusters[].[DBClusterIdentifier,Engine,EngineVersion,Status,MultiAZ,Endpoint]' --output table

# "RDS snapshots"
aws rds describe-db-snapshots \
  --query 'DBSnapshots[].[DBSnapshotIdentifier,DBInstanceIdentifier,Engine,Status,SnapshotCreateTime]' --output table

# "RDS parameter groups"
aws rds describe-db-parameter-groups \
  --query 'DBParameterGroups[].[DBParameterGroupName,DBParameterGroupFamily]' --output table

# "RDS subnet groups"
aws rds describe-db-subnet-groups \
  --query 'DBSubnetGroups[].[DBSubnetGroupName,VpcId]' --output table
```

#### DynamoDB
```bash
# "DynamoDB tables" / "list NoSQL tables"
aws dynamodb list-tables --query 'TableNames' --output table

# "DynamoDB table details for <name>"
aws dynamodb describe-table --table-name <name> \
  --query 'Table.[TableName,TableStatus,ItemCount,BillingModeSummary.BillingMode]'

# "DynamoDB backups"
aws dynamodb list-backups \
  --query 'BackupSummaries[].[TableName,BackupName,BackupStatus,BackupCreationDateTime]' --output table

# "DynamoDB global tables"
aws dynamodb list-global-tables \
  --query 'GlobalTables[].[GlobalTableName,ReplicationGroup[].RegionName]' --output table
```

#### ElastiCache & Redshift
```bash
# "ElastiCache clusters" / "Redis clusters"
aws elasticache describe-cache-clusters \
  --query 'CacheClusters[].[CacheClusterId,Engine,EngineVersion,CacheNodeType,CacheClusterStatus]' --output table

# "ElastiCache replication groups"
aws elasticache describe-replication-groups \
  --query 'ReplicationGroups[].[ReplicationGroupId,Status,AutomaticFailover]' --output table

# "Redshift clusters" / "data warehouse"
aws redshift describe-clusters \
  --query 'Clusters[].[ClusterIdentifier,ClusterStatus,NodeType,NumberOfNodes,Endpoint.Address]' --output table

# "DocumentDB clusters"
aws docdb describe-db-clusters \
  --query 'DBClusters[].[DBClusterIdentifier,Status,Engine,Endpoint]' --output table

# "Neptune clusters" / "graph databases"
aws neptune describe-db-clusters \
  --query 'DBClusters[].[DBClusterIdentifier,Status,Engine,Endpoint]' --output table
```

---
