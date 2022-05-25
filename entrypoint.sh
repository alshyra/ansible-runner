#!/usr/bin/env sh

ansible --version
pip3 install -r requirements.txt
ansible-galaxy install -r requirements.yml
ansible $@
