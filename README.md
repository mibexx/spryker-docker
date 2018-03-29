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
    image: nginx:alpine
    volumes:
      - filestorage:/data
      - ./env/conf/spryker/[app]_[store].conf:/etc/nginx/conf.d/default.conf
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

Next you have to create the [app]_[store].conf file in ./env/conf/spryker.  
This is the vhost configuration for your new container. Copy an existent configuration and change root_path, server_name, log-paths, APPLICATION_ENV and APPLICATION_STORE if needed.  

*Example for zed*  
```bash
server {
    listen 80;

    root /data/shop/development/current/public/Zed;
    index index.php;

    server_name zed.de.suite.local;

    access_log /var/log/nginx/zed-de-access.log;
    error_log /var/log/nginx/zed-de-error.log;

    proxy_read_timeout 600s;
    proxy_send_timeout 600s;
    fastcgi_read_timeout 600s;
    client_body_timeout 600s;
    client_header_timeout 600s;
    send_timeout 600s;

    location ~ (/images/|/scripts|/styles|/fonts|/bundles|/favicon.ico|/robots.txt) {
        access_log        off;
        expires           30d;
        add_header Pragma public;
        add_header Cache-Control "public, must-revalidate, proxy-revalidate";
        try_files $uri =404;
    }

    location /payone/ {
        auth_basic off;
        add_header X-Server $hostname;
        try_files $uri @rewriteapp;
    }

    location / {
        if (-f $document_root/maintenance.html) {
            return 503;
        }

        add_header X-Server $hostname;

        try_files $uri @rewriteapp;
    }

    location @rewriteapp {
        rewrite ^(.*)$ /index.php last;
    }

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass admin:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
        fastcgi_param APPLICATION_ENV development;
        fastcgi_param APPLICATION_STORE DE;
    }
}
```


The last step is to add your server to the loadbalancer. For that you have to edit the file ./env/conf/loadbalancer/loadbalancer.conf.  
Add that for every new server:  

```bash
server {
    listen 80;

    server_name [domain];

    access_log /var/log/nginx/[app]-[store]-access.log;
    error_log /var/log/nginx/[app]-[store]-error.log;

    location / {
        proxy_pass http://[service];
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

***Replace variables:***

| Variable | Description | Example |
| -------- | ----------- | ------- |
| [service] | Name of your service | yves_at |
| [app] | Type of your application | yves |
| [store] | Your store | at |
| [domain] | Your domain | www.at.suite.local |