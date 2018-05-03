#!/usr/bin/sh

RABBITMQ_CONTAINER=$(docker ps --filter name="rabbitmq" -q | awk '{ print $1 }')

docker exec -it $RABBITMQ_CONTAINER rabbitmqctl add_vhost /DE_development_zed
docker exec -it $RABBITMQ_CONTAINER rabbitmqctl add_user DE_development mate20mg
docker exec -it $RABBITMQ_CONTAINER rabbitmqctl set_user_tags DE_development administrator
docker exec -it $RABBITMQ_CONTAINER rabbitmqctl set_permissions -p /DE_development_zed DE_development ".*" ".*" ".*"
docker exec -it $RABBITMQ_CONTAINER rabbitmqctl add_vhost /US_development_zed
docker exec -it $RABBITMQ_CONTAINER rabbitmqctl add_user US_development mate20mg
docker exec -it $RABBITMQ_CONTAINER rabbitmqctl set_user_tags US_development administrator
docker exec -it $RABBITMQ_CONTAINER rabbitmqctl set_permissions -p /US_development_zed US_development ".*" ".*" ".*"