### CROSS-SERVICE QUERIES

```bash
# "resources tagged Environment=production" / "all production resources"
aws resourcegroupstaggingapi get-resources \
  --tag-filters Key=Environment,Values=production \
  --query 'ResourceTagMappingList[].[ResourceARN]' --output table

# "all resources tagged <key>=<value>"
aws resourcegroupstaggingapi get-resources \
  --tag-filters Key=<key>,Values=<value> \
  --query 'ResourceTagMappingList[].[ResourceARN,Tags]' --output table

# "inventory of all resources" (AWS Config)
aws configservice list-discovered-resources --resource-type <type> \
  --query 'resourceIdentifiers[].[resourceType,resourceId,resourceName]' --output table
```

---
