FROM mibexx/spryker-php
MAINTAINER Mike Bertram <contact@mibexx.de>

ENV DEBIAN_FRONTEND "noninteractive"
ENV ROOT_PASSWORD "root"

RUN apt-get update \
 && apt-get install -y openssh-server locales \
 && sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
 && mkdir -p /var/run/sshd \
 && rm -rf /var/lib/apt/lists/*


RUN export LANGUAGE=de_DE.UTF-8 \
 && export LANG=de_DE.UTF-8 \
 && export LC_ALL=de_DE.UTF-8 \
 && locale-gen de_DE.UTF-8 \
 && locale-gen de_DE.UTF-8 \
 && dpkg-reconfigure locales

WORKDIR "/data/shop/development"

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD []

EXPOSE 22