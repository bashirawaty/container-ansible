# container-ansible
Ansible run from a docker container
Curtosy of [Marko](http://ruleoftech.com/2017/dockerizing-all-the-things-running-ansible-inside-docker-container) 

# Install
`docker pull johnsondnz/ansible:latest`

# Build your own
`docker build -t {{username}}/{{image-0ame}} .`

# Pull and test images
```
docker run --rm -it -v $(pwd):/ansible/playbooks \
    walokra/ansible-playbook --version
```
    
# Execute playbook
```
docker run --rm -it -v $(pwd):/ansible/playbooks \
    walokra/ansible-playbook site.yml
```
    
# Execute playbook and include ssh keys
```
docker run --rm -it \
    -v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
    -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
    -v $(pwd):/ansible/playbooks \
    walokra/ansible-playbook site.yml
```

# Shell script wrapper
```
#!/usr/bin/env bash
docker run --rm -it \
  -v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
  -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
  -v $(pwd):/ansible_playbooks \
  -v /var/log/ansible/ansible.log \
  walokra/ansible-playbook "$@"
```

`./ansible_helper play playbooks/deploy.yml -i inventory/dev -e 'some_var=some_value'`
