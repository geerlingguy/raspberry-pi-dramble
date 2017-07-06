#!/bin/bash
#
# Shell script to test individual components of the Raspberry Pi Dramble stack
# on Docker containers.
#
# This is hacky, but it does what I need it to do :)
#
# Usage:
#   export playbook=balancer
#   ./docker-playbook-test.sh

playbook=${playbook:-balancer}

# Run a Docker container for the playbook to run inside.
docker run --detach \
  --volume=$(pwd):/etc/ansible/pi-dramble:rw \
  --name $playbook \
  --privileged \
  --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro \
  geerlingguy/docker-debian8-ansible:latest \
  /lib/systemd/systemd

# Install requirements.
docker exec --tty $playbook env TERM=xterm ansible-galaxy install -r /etc/ansible/pi-dramble/playbooks/requirements.yml

# Check the playbook's syntax.
docker exec --tty $playbook env TERM=xterm \
  ansible-playbook /etc/ansible/pi-dramble/playbooks/$playbook/$playbook.yml --syntax-check

# Run the playbook.
docker exec --tty $playbook env TERM=xterm \
  ansible-playbook /etc/ansible/pi-dramble/playbooks/$playbook/$playbook.yml --connection=local \
  -i /etc/ansible/pi-dramble/testing/docker/inventory \
  --extra-vars "deploy_target=docker"
