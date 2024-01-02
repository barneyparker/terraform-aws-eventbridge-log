resource "aws_cloudwatch_log_group" "event_log" {
  name              = var.log_group_name
  retention_in_days = var.retention_in_days
}

data "aws_iam_policy_document" "event_log" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream"
    ]

    resources = [
      "${aws_cloudwatch_log_group.event_log.arn}:*"
    ]

    principals {
      type = "Service"
      identifiers = [
        "events.amazonaws.com",
        "delivery.logs.amazonaws.com"
      ]
    }
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:PutLogEvents"
    ]

    resources = [
      "${aws_cloudwatch_log_group.event_log.arn}:*:*"
    ]

    principals {
      type = "Service"
      identifiers = [
        "events.amazonaws.com",
        "delivery.logs.amazonaws.com"
      ]
    }

    condition {
      test     = "ArnEquals"
      values   = [aws_cloudwatch_event_rule.event_log.arn]
      variable = "aws:SourceArn"
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "event_log" {
  policy_document = data.aws_iam_policy_document.event_log.json
  policy_name     = "all-events-log-publishing-policy"
}

# rule/target for sre bus
resource "aws_cloudwatch_event_rule" "event_log" {
  name           = "event-log"
  description    = "Log all events"
  event_bus_name = var.event_bus_name

  event_pattern = jsonencode(
    {
      source = [{
        prefix = ""
      }]
    }
  )
}

resource "aws_cloudwatch_event_target" "event_log" {
  rule           = aws_cloudwatch_event_rule.event_log.name
  event_bus_name = var.event_bus_name
  arn            = aws_cloudwatch_log_group.event_log.arn
}

