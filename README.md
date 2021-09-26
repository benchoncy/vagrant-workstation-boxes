# Vagrant Box Workstation Builds

This project holds the Packer build configurations for linux desktop environments. Each box builds a workstation to use with Vagrant and VirtualBox as its provider.

All boxes are public, available builds:
- [benchoncy/ubuntu-focal64-desktop-workstation](https://app.vagrantup.com/benchoncy/boxes/ubuntu-focal64-desktop-workstation)
- [benchoncy/fedora-34-desktop-workstation](https://app.vagrantup.com/benchoncy/boxes/fedora-34-desktop-workstation)

## Prerequisites

In order to run any builds, the following software must be first installed:
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/)
- [VirtualBox](https://www.virtualbox.org/)
- [Packer](https://www.packer.io/downloads)
- [Vagrant](https://www.vagrantup.com/downloads)

## Build

Ensure all required prerequisites are installed, then a build can be run using:

```shell
packer build -var='version=<VERSION>' box-config.pkr.hcl
```

### Variables

The follwing variables can be passed to `packer build` using the `-var` flag:

| Variable | Note |
| ----------- | ----------- |
| `version` | Specifies the resulting build version tag. |
| `cloud_token` | `cloud_token` is the vagrant cloud token to authenticate for permission to upload boxes. If `cloud_token` is not specified packer will look for the `VAGRANT_CLOUD_TOKEN` environnement variable. |
| `org` | Defaults to `benchoncy`, can be used to specify a different organisation on vagrant cloud to upload to. |