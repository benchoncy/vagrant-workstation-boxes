#!/bin/bash

# destroy any vagrant boxes
vagrant -y destroy

# clear vagrant boxes
vagrant box list | cut -f 1 -d ' ' | xargs -L 1 vagrant box remove -f