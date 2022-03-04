data "template_file" "installapche2" {
    template = file("init.cfg")
  }

  data "template_cloudinit_config" "install-apache-config" {
      gzip = false
      base64_encode = false
    part {
      file_name = "init.cfg"
      content_type = "text/cloud-config"
      content = data.template_file.installapche2.rendered
    }
  }