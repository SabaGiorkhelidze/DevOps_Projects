#!/bin/bash
ANSIBLE_STDOUT_CALLBACK=default ansible-playbook $(dirname "$0")/playbooks/monitor_system.yml -i $(dirname "$0")/inventories/hosts.ini