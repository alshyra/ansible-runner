FROM alpine:3.15.4

COPY --chown=root:root ./config/ssh.config /root/.ssh/config
COPY --chown=root:root entrypoint.sh /entrypoint

RUN apk --update --no-cache add python3-dev \
    openssh-keygen \
    bash \
    build-base \
    libffi libffi-dev --virtual .build-deps && \
    apk add python3 py3-pip openssh && \
    pip3 install --upgrade pip && pip install ansible && \
    ssh-keygen -t ed25519 -q -f "$HOME/.ssh/id_rsa" -N "" && \
    chmod 600 /root/.ssh/config && \
    apk del .build-deps

WORKDIR /ansible
ENTRYPOINT [ "/entrypoint" ]
