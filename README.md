# container-ansible
Ansible run from a docker container
Based on [Marko](http://ruleoftech.com/2017/dockerizing-all-the-things-running-ansible-inside-docker-container) 


# Install
`docker pull johnsondnz/ansible:latest`

# Build your own
`docker build -t {{username}}/{{image-name}} --build-arg ANSIBLE_VERSION=<version>.`

# Add other python packages
Add them to requirements.txt and build as required.

# Pull and test images
```
docker run --rm -it -v $(pwd):/ansible/playbooks \
    johnsondnz/ansible:latest --version
```
    
# Execute playbook
```
docker run --rm -it -v $(pwd):/ansible/playbooks \
    johnsondnz/ansible:latest site.yml
```

# Execute playbook with inventory
```
docker run --rm -it -v $(pwd):/ansible/playbooks \
    johnsondnz/ansible:latest site.yml -i inventory
```

# Execute playbook with verbose
```
docker run --rm -it -v $(pwd):/ansible/playbooks \
    johnsondnz/ansible:latest site.yml -i inventory -v
```
    
# Execute playbook and include ssh keys
```
docker run --rm -it \
    -v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
    -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
    -v $(pwd):/ansible/playbooks \
    johnsondnz/ansible:latest site.yml
```

# Logging
Ansible doesn't generate logs by default.  create `ansible.cfg` and add the following snippet to the `[default]` section, change as required.
```
log_path=/var/log/ansible/ansible.log
```

Next, create a persistent storage volume with `-v path_to_logs:/var/log/ansible`

# Shell script wrapper
```
#!/usr/bin/env bash
docker run --rm -it \
  -v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
  -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
  -v $(pwd):/ansible_playbooks \
  -v $(pwd):/var/log/ansible/ansible.log \
  johnsondnz/ansible:latest "$@"
```
