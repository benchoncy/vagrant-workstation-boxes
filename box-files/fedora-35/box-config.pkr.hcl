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

source "virtualbox-iso" "fedora-35" {
  guest_os_type = "Fedora_64"
  vm_name = "fedora-35-workstation"
  output_directory = "output/fedora-35/virtualbox"
  iso_url = "https://download.fedoraproject.org/pub/fedora/linux/releases/35/Everything/x86_64/iso/Fedora-Everything-netinst-x86_64-35-1.2.iso"
  iso_checksum = "d52d74970bc2c7d46a5e92c841951e96febb2aa8952e9259ea75cf1212f24a0a"
  ssh_username = "root"
  ssh_password = "vagrant"
  ssh_port = 22
  ssh_timeout = "3600s"
  shutdown_command = "sudo -S shutdown -P now"
  boot_wait = "20s"
  boot_keygroup_interval = "1s"
  boot_command = [
    "<tab> ",
    "<wait>text net.ifnames=0 ",
    "<wait>inst.ks=http://{{.HTTPIP}}:{{.HTTPPort}}/kickstart.ks ",
    "<wait><enter>"
  ]
  http_directory = "./http"
  headless = true
  cpus = 2
  memory = 8192
}

build {
  sources = ["source.virtualbox-iso.fedora-35"]

  provisioner "shell" {
    scripts = [
      "scripts/vagrant.sh"
    ]
    timeout = "20m"
  }

  post-processors {
    post-processor "vagrant" {
      keep_input_artifact = true
      output = "output/{{.BuildName}}/{{.Provider}}/packer.box"
    }

    post-processor "vagrant-cloud" {
      access_token = "${var.cloud_token}"
      box_tag = "${var.org}/${source.name}-desktop-workstation"
      version = "${var.version}"
    }
  }
}