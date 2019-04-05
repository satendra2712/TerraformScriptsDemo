variable "region" {}
variable "resource_group_name" {}
variable "project" {}

variable "environment" {
  description = "The name of the environment"
}

variable "common_tags" {
  type = "map"
}

variable "name" {}

variable "app_settings" {
  type = "map"
}

variable "db_connection_string" {
  default = ""
}

variable "registry_login_server" {}
variable "registry_admin_username" {}
variable "registry_admin_password" {}
variable "docker_image" {}
