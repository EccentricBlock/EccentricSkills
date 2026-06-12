### STORAGE

#### S3
```bash
# "list S3 buckets" / "show my buckets"
aws s3api list-buckets --query 'Buckets[].[Name,CreationDate]' --output table

# "S3 bucket encryption for <name>"
aws s3api get-bucket-encryption --bucket <name>

# "S3 bucket versioning for <name>"
aws s3api get-bucket-versioning --bucket <name>

# "S3 public access settings for <name>"
aws s3api get-public-access-block --bucket <name>

# "S3 lifecycle rules for <name>"
aws s3api get-bucket-lifecycle-configuration --bucket <name>

# "S3 bucket policy for <name>"
aws s3api get-bucket-policy --bucket <name>

# "list objects in s3://<bucket>/<prefix>"
aws s3api list-objects-v2 --bucket <bucket> --prefix <prefix> \
  --query 'Contents[].[Key,Size,LastModified,StorageClass]' --output table
```

#### EBS & EFS
```bash
# "EBS volumes" / "list volumes"
aws ec2 describe-volumes \
  --query 'Volumes[].[VolumeId,Size,VolumeType,State,AvailabilityZone,Attachments[0].InstanceId]' --output table

# "unattached EBS volumes" / "unused volumes"
aws ec2 describe-volumes --filters Name=status,Values=available \
  --query 'Volumes[].[VolumeId,Size,VolumeType,CreateTime]' --output table

# "EBS snapshots I own"
aws ec2 describe-snapshots --owner-ids self \
  --query 'Snapshots[].[SnapshotId,VolumeId,State,StartTime]' --output table

# "EFS file systems"
aws efs describe-file-systems \
  --query 'FileSystems[].[FileSystemId,Name,LifeCycleState,SizeInBytes.Value,ThroughputMode]' --output table
```

---
