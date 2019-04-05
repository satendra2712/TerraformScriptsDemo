locals {
  project       = "${lower(format("%s-%s", var.application, var.environment))}"
  is_production = "${lower(var.environment) == "prod"}"

  common_tags = {
    Application = "${var.application}"
    Environment = "${var.environment}"
    Author      = "${var.author}"
  }
}
