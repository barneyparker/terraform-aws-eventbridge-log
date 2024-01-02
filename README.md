# Terraform-AWS-EventBridge-Log

This module creates a CloudWatch Log Group and a CloudWatch EventBridge Rule to send events to the Log Group.

## Usage

```hcl
resource "aws_cloudwatch_event_bus" "event_bus" {
  name = "my-event-bus"
}

module "event_bus_audit_log" {
  source = "barneyparker/eventbridge-log/aws"

  event_bus_name = aws_cloudwatch_event_bus.event_bus.name
  log_group_name = "/event/audit-log"
  retention_in_days = 90
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| event\_bus\_name | The name of the EventBridge bus to send events to | `string` | n/a | yes |
| log\_group\_name | The name of the CloudWatch Log Group to send events to | `string` | `"/aws/events/log"` | no |
| retention\_in\_days | The number of days to retain events in the CloudWatch Log Group | `number` | `30` | no |


## Outputs

N/A