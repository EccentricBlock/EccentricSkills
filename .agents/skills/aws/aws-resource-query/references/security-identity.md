### SECURITY & IDENTITY

#### IAM
```bash
# "IAM users" / "list users"
aws iam list-users \
  --query 'Users[].[UserName,UserId,CreateDate,PasswordLastUsed]' --output table

# "IAM roles" / "list roles"
aws iam list-roles \
  --query 'Roles[].[RoleName,RoleId,CreateDate]' --output table

# "IAM policies attached to role <name>"
aws iam list-attached-role-policies --role-name <name> \
  --query 'AttachedPolicies[].[PolicyName,PolicyArn]' --output table

# "IAM groups"
aws iam list-groups \
  --query 'Groups[].[GroupName,GroupId,CreateDate]' --output table

# "IAM policies (customer managed)"
aws iam list-policies --scope Local \
  --query 'Policies[].[PolicyName,AttachmentCount,CreateDate]' --output table

# "who has MFA enabled" / "MFA devices"
aws iam list-virtual-mfa-devices \
  --query 'VirtualMFADevices[].[SerialNumber,User.UserName,EnableDate]' --output table

# "IAM account password policy"
aws iam get-account-password-policy

# "IAM account summary"
aws iam get-account-summary
```

#### Secrets Manager
```bash
# "list secrets" / "Secrets Manager secrets" / "show secrets"
aws secretsmanager list-secrets \
  --query 'SecretList[].[Name,ARN,LastChangedDate,LastAccessedDate,Description]' --output table

# "secret metadata for <name>"
aws secretsmanager describe-secret --secret-id <name> \
  --query '{Name:Name,ARN:ARN,RotationEnabled:RotationEnabled,LastRotatedDate:LastRotatedDate,Tags:Tags}'

# "secrets with rotation enabled"
aws secretsmanager list-secrets \
  --query 'SecretList[?RotationEnabled==`true`].[Name,LastRotatedDate]' --output table
```

> ⚠️ **Note**: Secret **values** are never retrieved (`get-secret-value` is excluded). Only metadata is shown.

#### SSM Parameter Store
```bash
# "SSM parameters" / "Parameter Store"
aws ssm describe-parameters \
  --query 'Parameters[].[Name,Type,LastModifiedDate,Description]' --output table

# "SSM parameters by path <path>"
aws ssm describe-parameters \
  --parameter-filters "Key=Path,Values=<path>" \
  --query 'Parameters[].[Name,Type,LastModifiedDate]' --output table
```

> ⚠️ **Note**: Parameter **values** are never retrieved (`get-parameter` is excluded). Only metadata is shown.

#### KMS & Certificates
```bash
# "KMS keys" / "encryption keys"
aws kms list-keys --query 'Keys[].[KeyId,KeyArn]' --output table

# "KMS key details for <id>"
aws kms describe-key --key-id <id> \
  --query 'KeyMetadata.[KeyId,Description,KeyState,KeyUsage,CreationDate,Enabled]'

# "KMS aliases"
aws kms list-aliases \
  --query 'Aliases[].[AliasName,AliasArn,TargetKeyId]' --output table

# "SSL certificates" / "ACM certificates"
aws acm list-certificates \
  --query 'CertificateSummaryList[].[CertificateArn,DomainName,Status,RenewalEligibility]' --output table

# "certificate details for <arn>"
aws acm describe-certificate --certificate-arn <arn> \
  --query 'Certificate.[DomainName,Status,NotAfter,NotBefore,InUseBy]'
```

#### GuardDuty, Security Hub & Config
```bash
# "GuardDuty detectors"
aws guardduty list-detectors --query 'DetectorIds' --output table

# "GuardDuty findings"
aws guardduty list-findings --detector-id <id> --query 'FindingIds' --output table

# "Security Hub findings"
aws securityhub get-findings \
  --query 'Findings[].[Title,Severity.Label,WorkflowState,UpdatedAt]' --output table

# "AWS Config rules"
aws configservice describe-config-rules \
  --query 'ConfigRules[].[ConfigRuleName,ConfigRuleState,Source.SourceIdentifier]' --output table

# "non-compliant resources"
aws configservice get-compliance-summary-by-config-rule \
  --query 'ComplianceSummariesByConfigRule[].[ConfigRuleName,Compliance.ComplianceType]' --output table
```

---
