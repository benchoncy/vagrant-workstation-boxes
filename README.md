# Vagrant Box Workstation Builds

This project holds the Packer build configurations for linux desktop environments. Each box builds a workstation to use with Vagrant.

All boxes are public, available builds:
- [benchoncy/ubuntu-2004-desktop-workstation](https://app.vagrantup.com/benchoncy/boxes/ubuntu-2004-desktop-workstation)
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
ansible-playbook build-boxes.yml
```

### Tags

The ansible playbook is tagged to help with controlling the flow of execution. available tags are listed below.

Example:
```shell
ansible-playbook build-boxes.yml --tags "version_check"
```

| Tag | Note |
| ----------- | ----------- |
| `version_check` | Runs extra tasks to output the new version to be created. |
| `debug` | Enable debug tasks, includes `version_check` |
| `clean` | Clean up steps, these run by default |

### Variables

To build requires a vagrant cloud token, this can be specified through the environnement variable `VAGRANT_CLOUD_TOKEN` or passed through the `--extra-vars` flag

| Variable | Note |
| ----------- | ----------- |
| `next_version_type` | Specifies what order of magnitude the next version should be, possible values include `major`, `minor` or `patch`. defaults to `minor`. |
| `vagrant_cloud_token` | `vagrant_cloud_token` is the vagrant cloud token to authenticate for permission to upload boxes. If `vagrant_cloud_token` is not specified packer will look for the `VAGRANT_CLOUD_TOKEN` environnement variable. |
| `boxes` | Defaults to all boxes, can be used to specify a different list to build. |
| `org` | Defaults to `benchoncy`, can be used to specify a different organisation on vagrant cloud to upload to. |

## Testing

### Running packer manually

For testing and development the below command can be used to run packer directly while only outputting boxes to a local directory.

```shell
packer build -force -only='*<TARGET_BOX>' -except='vagrant-cloud' box-config.pkr.hcl
```

Once packer is complete, you can navigate to `box-files/<TARGET_BOX>/` and run `vagrant up` to run the local box in vagrant.

#### Packer variables

The follwing variables can be passed to `packer build` using the `-var` flag:

| Variable | Note |
| ----------- | ----------- |
| `version` | (vagrant-cloud only) Specifies the resulting build version tag. |
| `cloud_token` | (vagrant-cloud only) `cloud_token` is the vagrant cloud token to authenticate for permission to upload boxes. If `cloud_token` is not specified packer will look for the `VAGRANT_CLOUD_TOKEN` environnement variable. |
| `org` | (vagrant-cloud only) Defaults to `benchoncy`, can be used to specify a different organisation on vagrant cloud to upload to. |