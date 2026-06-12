### COST & BILLING

```bash
# "current month cost" / "how much am I spending"
aws ce get-cost-and-usage \
  --time-period Start=$(date -u +%Y-%m-01),End=$(date -u +%Y-%m-%d) \
  --granularity MONTHLY --metrics BlendedCost \
  --query 'ResultsByTime[].[TimePeriod.Start,Total.BlendedCost.Amount,Total.BlendedCost.Unit]' \
  --output table

# "cost by service" / "spending breakdown"
aws ce get-cost-and-usage \
  --time-period Start=$(date -u -d '30 days ago' +%Y-%m-%d),End=$(date -u +%Y-%m-%d) \
  --granularity MONTHLY --metrics BlendedCost \
  --group-by Type=DIMENSION,Key=SERVICE --output table

# "AWS Budgets"
aws budgets describe-budgets \
  --account-id $(aws sts get-caller-identity --query Account --output text) \
  --query 'Budgets[].[BudgetName,BudgetType,BudgetLimit.Amount,CalculatedSpend.ActualSpend.Amount]' \
  --output table

# "Trusted Advisor recommendations"
aws support describe-trusted-advisor-checks --language en \
  --query 'checks[].[id,name,category]' --output table
```

---
