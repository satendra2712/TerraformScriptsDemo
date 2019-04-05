variable "name" {}
variable "region" {}
variable "resource_group_name" {}
variable "project" {}

variable "environment" {
  description = "The name of the environment"
}

variable "common_tags" {
  type = "map"
}
