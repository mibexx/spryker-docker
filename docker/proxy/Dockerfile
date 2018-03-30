FROM alpine:3.7
MAINTAINER Mike Bertram <contact@mibexx.de>

COPY entrypoint.sh /

ENV ROOT_PASSWORD "root"

RUN apk add --update \
 && apk add openssh \
 && rm -rf /var/cache/apk/* \
 && sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config

WORKDIR "/data/shop/development"

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 22