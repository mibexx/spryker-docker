FROM mibexx/spryker-php
MAINTAINER Mike Bertram <contact@mibexx.de>

ENV ROOT_PASSWORD "root"

RUN apt-get update \
 && apt-get install -y openssh-server \
 && sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config

WORKDIR "/data/shop/development"

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 22