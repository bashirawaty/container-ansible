# PROJECT MOVED TO GILAB.COM
https://gitlab.com/johnsondnz/container-ansible
This project will be archived.

# container-ansible
- Ansible run from a docker container
- Jenkins automated builds based on github push requests

# Install
`$ docker pull johnsondnz/ansible:latest`

# Build your own
`$ docker build -t <image-name> --build-arg ANSIBLE_VERSION=<version> .`

## Add other python packages
Add them to requirements.txt and build as required.

# Pull and test images
```
$ docker run --rm -it -v $(pwd):/ansible/playbooks \
     johnsondnz/ansible:latest <any-arguments (optional)>
```
## Suported Arguments
- --version (default)
- sh: opens shell
- bash: opens shell
- shell: opens shell
- all ansible-playbook options etc

## Important
It is recommended that you pass a username to ansible-playbook with the `-u` flag.  This is important when using SSH keys as the owner of the key must match the username that created it, otherwise access to read the private key is denied.  An exmaple can be found below.

## Example Run Output
```
ansible-playbook 2.8.3
  config file = None
  configured module search path = ['/ansible/library']
  ansible python module location = /usr/lib/python3.7/site-packages/ansible
  executable location = /usr/bin/ansible-playbook
  python version = 3.7.3 (default, May  3 2019, 11:24:39) [GCC 8.3.0]
```
    
## Execute playbook
```
$ docker run --rm -it -v $(pwd):/ansible/playbooks \
     johnsondnz/ansible:latest site.yml
```

## Execute playbook with inventory
```
$ docker run --rm -it -v $(pwd):/ansible/playbooks \
     johnsondnz/ansible:latest site.yml -i inventory
```

## Execute playbook with verbose and sudo
```
$ docker run --rm -it -v $(pwd):/ansible/playbooks \
     johnsondnz/ansible:latest site.yml -i inventory -v -K
```
    
## Execute playbook, include ssh keys and username
Provides read-only access to SSH private and public keys for the current user.
```
$ docker run --rm -it \
     -v ~/.ssh/id_rsa:/root/.ssh/id_rsa:ro \
     -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub:ro \
     -v $(pwd):/ansible/playbooks \
     johnsondnz/ansible:latest site.yml -u $(whoami)
```

# Logging
Ansible doesn't generate logs by default.  create `ansible.cfg` and add the following snippet to the `[default]` section, change as required.
```
[default]
log_path=/var/log/ansible/ansible.log
```

To create a persistent storage volume add `-v path_to_logs:/var/log/ansible` to the `docker run` command.
