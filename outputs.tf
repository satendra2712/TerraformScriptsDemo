output "default_site_hostname" {
  value = "${module.api.default_site_hostname}"
}

resource "local_file" "publish_template" {
  content  = "${data.template_file.publish_template.rendered}"
  filename = "hello-world/publish-${var.environment}.ps1"
}

data "template_file" "publish_template" {
  template = "${file("hello-world/publish.template")}"

  vars {
    registry_name         = "${module.container-registry.name}"
    registry_login_server = "${module.container-registry.login_server}"
  }
}
