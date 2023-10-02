# variables.tf

variable "user_uuid" {
  description = "User UUID"
  type        = string
  default     = "f0e61796-d3e3-4491-806d-03ac807bc685"

  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.user_uuid))
    error_message = "User UUID must be in the format of a UUID (e.g., 123e4567-e89b-12d3-a456-426614174000)"
  }
}
