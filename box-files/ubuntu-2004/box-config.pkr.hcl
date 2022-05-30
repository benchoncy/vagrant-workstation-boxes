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

source "vagrant" "ubuntu-2004" {
  communicator = "ssh"
  source_path = "ubuntu/focal64"
  provider = "virtualbox"
  add_force = true
  add_clean = true
  output_dir = "output/virtualbox/ubuntu-2004"
}

build {
  sources = ["sources.vagrant.ubuntu-2004"]

  provisioner "ansible" {
    playbook_file = "./playbook.yml"
    user = "vagrant"
  }

  post-processor "vagrant-cloud" {
    access_token = "${var.cloud_token}"
    box_tag = "${var.org}/${source.name}-desktop-workstation"
    version = "${var.version}"
  }
}