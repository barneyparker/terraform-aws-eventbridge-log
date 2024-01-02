resource "aws_cloudwatch_event_bus" "event_bus" {
  name = "my-event-bus"
}

module "event_bus_audit_log" {
  source = "../"

  event_bus_name    = aws_cloudwatch_event_bus.event_bus.name
  log_group_name    = "/event/audit-log"
  retention_in_days = 90
}
