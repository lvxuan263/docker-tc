FROM docker:stable

RUN echo "===> Installing sudo to emulate normal OS behavior..." && \
    apk add --no-cache --virtual .fetch-deps yarn; \
    \
    echo "===> Adding Python runtime..."  && \
    apk add --no-cache --virtual .fetch-deps \
        python \
        py-pip \
        openssl \
        python-dev \
        libffi-dev \
        openssl-dev \
        build-base && \
    \    
    echo "===> Adding gyp build runtimes..."  && \
    apk add --no-cache --virtual .fetch-deps \
        make \
        g++ && \
    \  
    echo "===> Installing Ansible..."  && \
    pip install --no-cache-dir --upgrade pip cffi ansible && \
    \
    echo "===> Installing handy tools (not absolutely required)..."  && \
    apk add --no-cache --virtual .fetch-deps \
        sshpass \
        openssh-client \
        rsync && \
    pip install --no-cache-dir --upgrade pip cffi ansible \
    \
    apk del .fetch-deps && \
    \
    echo "===> Adding hosts for convenience..."  && \
    mkdir -p /etc/ansible                        && \
    echo 'localhost' > /etc/ansible/hosts
