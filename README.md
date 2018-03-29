Spryker Docker
=====

Simple docker stack environment for spryker suite development.

Use in spryker project
--------------------------

Copy env-directory and compose-file to your spryker repository. It's recommended to have your spryker source in a "current" directory.  
After running the environment you can add your source to the environment:  

```bash

# With docker to admin-server
docker cp ./current admin:/data/shop/development/

# With ssh to proxy-server
scp -r -P <ssh-port> ./current root@<dockerhost>:/data/shop/development/

*SSH Password is defined in your compose file. It's "spryker" for default.

```


Deploy environment (production)
------------------

Beware: This is not a setup for a real production environment.    
Production means: There are only port 80 on loadbalancer and port 22 for proxy container open.  

***Command:***  
docker stack deploy -c docker-production.yml spryker


Deploy environment (development)
------------------

***Command:***  
docker stack deploy -c docker-development.yml spryker

In development there a two more services: mailcatcher and redisui.



Reachable Spryker Domains (Default)
--------------------------

| URL | Description |
| ------- | ----------- |
| http://www.de.suite.local | Spryker YVES |
| http://zed.de.suite.local | Spryker ZED |



Published Ports
--------------------------

Port "?" means, that docker swarm create a dynamic port.  
Port "-" means, that there is no public port for that.    


| Port Internal | Port development | Port production | Description / Target |
| ------------- | ---------------- | --------------- | -------------------- |
| 22 | ? | ? | Proxy-Server to change data or tunnel ports |
| 80 | 80 | 80 | Loadbalancer |
| 1080 | 1080 | - | Mailcatcher UI (only in development) |
| 5432 | 5432 | - | Postgres |
| 6379 | 6379 | - | Redis |
| 8081 | 8081 | - | Redis UI (only in development) |
| 8080 | 8080 | - | Jenkins |
| 9200 | 9200 | - | Elasticsearch |
| 15672 | 15672 | - | RabbitMQ |


How to add stores
----------------------

You can edit the compose-file and add own yves/zed container.  
Use this service-template for that:  
```    
  [service]:
    image: nginx-alpine
    volumes:
      - filestorage:/data
      - ./env/conf/spryker/spryker.conf:/etc/nginx/conf.d/spryker.conf
    - ./env/conf/spryker/spryker_params_[app]_[store]:/etc/nginx/spryker_params
    depends_on:
      - admin
    deploy:
      replicas: 1
      update_config:
        parallelism: 2
        delay: 10s
      restart_policy:
        condition: on-failure
    networks:
      default:
        aliases:
          - "[domain]"
```

***Replace variables:***

| Variable | Description | Example |
| -------- | ----------- | ------- |
| [service] | Name of your service | yves_at |
| [app] | Type of your application | yves |
| [store] | Your store | at |
| [domain] | Your domain | www.at.suite.local |


Also you have to create the file *./env/conf/spryker/spryker_params_[app]_[store]*

Example:
```
set $spryker_app_name "Yves";
set $spryker_app_url "www.at.suite.local";
set $spryker_app_env "development";
set $spryker_app_store "AT";
```