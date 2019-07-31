FROM alpine:latest
ARG ANSIBLE_VERSION=2.8.3

LABEL maintainer="Donald Johnson <@johnsonnz>"

COPY requirements.txt /tmp

RUN set -x && \
    echo "==> Install dependencies" && \
    apk add --no-cache --update python3 ca-certificates openssh-client sshpass dumb-init su-exec && \
    echo "==> Install dev libraries" && \
    apk add --no-cache --update --virtual .build-deps python3-dev build-base libffi-dev openssl-dev && \
    echo "==> Update pip" && \
    pip3 install --no-cache-dir --upgrade pip && \
    echo "==> Install ansible" && \
    pip3 install --no-cache-dir --upgrade setuptools ansible==${ANSIBLE_VERSION} && \
    echo "==> Checking for requirements.txt with contents" && \
    [ -s /tmp/requirements.txt ] && echo "==> Install more pip packages" && pip3 install --no-cache-dir -r /tmp/requirements.txt || echo "==> No additional packages to install" && \
    echo "==> Cleanup" && \
    apk del --no-cache --purge .build-deps && \
    rm -rf /var/cache/apk/* && \
    rm -rf /root/.cache && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    rm /tmp/requirements.txt && \
    \
    echo "==> Adding hosts for convenience..."  && \
    mkdir -p /etc/ansible /ansible && \
    echo "[local]" >> /etc/ansible/hosts && \
    echo "localhost" >> /etc/ansible/host && \
    echo "==> Installed python modules..." && \
    pip3 list
 
ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PYTHONPATH /ansible/lib
ENV PATH /ansible/bin:$PATH
ENV ANSIBLE_LIBRARY /ansible/library
 
WORKDIR /ansible/playbooks
 
ENTRYPOINT ["ansible-playbook"]
