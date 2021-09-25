#!/usr/bin/env bash

version="1.0.0"
org="benchoncy"

boxes=(
    'ubuntu-focal64-desktop-workstation'
    'fedora-34-desktop-workstation'
    )

for box in "${boxes[@]}"; do
    echo "Destroying existing $box box..."
    vagrant destroy -f $box
    echo "Creating Vagrant box $box..."
    vagrant up $box
    echo "Halting box $box..."
    vagrant halt $box
    echo "Packaging $box..."
    vagrant package $box --output $box.box
    echo "Publishing $box v$version..."
    vagrant cloud publish $org/$box $version virtualbox $box.box
done