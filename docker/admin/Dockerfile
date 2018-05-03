FROM mibexx/spryker-php
MAINTAINER Mike Bertram <contact@mibexx.de>

ENV ROOT_PASSWORD "root"

RUN apt-get update \
 && apt-get install -y openssh-server locales \
 && sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
 && mkdir -p /var/run/sshd \
 && rm -rf /var/lib/apt/lists/*


ENV LANGUAGE "de_DE.UTF-8"
ENV LANG "de_DE.UTF-8"
ENV LC_ALL "de_DE.UTF-8"

RUN locale-gen de_DE.UTF-8

WORKDIR "/data/shop/development"

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD []

EXPOSE 22