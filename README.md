# container-ansible
Ansible run from a docker container
Courtesy of [Marko](http://ruleoftech.com/2017/dockerizing-all-the-things-running-ansible-inside-docker-container) 

## Changes
* 27.11.2018 - Added libxslt-dev, libxml2-dev, libffi-dev, nccclient, junos-eznc.
* 26.11.2018 - First release.

# Install
`docker pull johnsondnz/ansible:latest`

# Build your own
`docker build -t {{username}}/{{image-name}} .`

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

# Shell script wrapper
```
#!/usr/bin/env bash
docker run --rm -it \
  -v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
  -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
  -v $(pwd):/ansible_playbooks \
  -v /var/log/ansible/ansible.log \
  johnsondnz/ansible:latest "$@"
```

`./ansible_helper play playbooks/deploy.yml -i inventory/dev -e 'some_var=some_value'`
