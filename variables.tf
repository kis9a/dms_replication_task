variable "prefix" {
  type = string
}

variable "source_map" {
  type = map(any)
}

variable "target_map" {
  type = map(any)
}

variable "table_mappings_string" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "instance_class" {
  type = string
}

variable "allocated_storage" {
  type = string
}

variable "migration_type" {
  type = string
}

variable "apply_immediately" {
  type    = bool
  default = false
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "public_accessible" {
  type    = string
  default = false
}

variable "kms_key_arn" {
  type    = string
  default = null
}
