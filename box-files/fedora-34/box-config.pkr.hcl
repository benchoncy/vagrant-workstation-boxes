variable "version" {
  type = string
  default = ""
}

variable "cloud_token" {
  type = string
  default = "${env("VAGRANT_CLOUD_TOKEN")}"
}

variable "org" {
  type = string
  default = "benchoncy"
}

source "vagrant" "fedora-34" {
  communicator = "ssh"
  source_path = "generic/fedora34"
  provider = "virtualbox"
  add_force = true
  add_clean = true
  output_dir = "output/virtualbox/fedora-34"
}

build {
  sources = ["sources.vagrant.fedora-34"]

  provisioner "ansible" {
    playbook_file = "./playbook.yml"
  }

  post-processor "vagrant-cloud" {
    access_token = "${var.cloud_token}"
    box_tag = "${var.org}/${source.name}-desktop-workstation"
    version = "${var.version}"
  }
}