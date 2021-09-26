variable "version" {
  type = string
}

variable "cloud_token" {
  type = string
  default = "${env("VAGRANT_CLOUD_TOKEN")}"
}

variable "org" {
  type = string
  default = "benchoncy"
}

source "vagrant" "ubuntu-focal64" {
  communicator = "ssh"
  provider = "virtualbox"
  source_path = "ubuntu/focal64"
  add_force = true
}

source "vagrant" "fedora-34" {
  communicator = "ssh"
  provider = "virtualbox"
  source_path = "generic/fedora34"
  add_force = true
}

build {
  sources = [
    "source.vagrant.ubuntu-focal64",
    "source.vagrant.fedora-34"
  ]

  provisioner "ansible" {
    playbook_file = "./playbook.yml"
  }

  post-processor "vagrant-cloud" {
    access_token = "${var.cloud_token}"
    box_tag      = "${var.org}/${source.name}-desktop-workstation"
    version      = "${var.version}"
  }
}