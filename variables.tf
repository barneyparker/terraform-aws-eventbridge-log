variable "event_bus_name" {
  type        = string
  description = "Event bus name"
}
variable "log_group_name" {
  type        = string
  description = "Log group name"
  default     = "/aws/events/log"
}

variable "retention_in_days" {
  type        = number
  description = "Log retention in days"
  default     = 30
}
