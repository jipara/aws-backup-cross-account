variable "backup_vault_name" {
  type = string
}
variable "kms_key_arn" {
  type = string
}

variable "backup_plan_name" {
  type = string
}

variable "rule_name" {
  type = string
}

variable "target_vault_name" {
  type = string
}

variable "schedule" {
  type = string
}

variable "destination_vault_arn" {
  type = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = null
}
