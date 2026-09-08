+++
date = '2026-02-25T12:29:40Z'
draft = false
title = 'Compose'
+++
# Docker Compose

### The Compose Configuration File
The Docker Compose file is generally named:
```
compose.yaml
```

But may also be named:
```
compose.yml
docker-compose.yaml
docker-compose.yml
```

All of these filenames will be searched for, in the above order, by the command line tool, however any filename may be used by supplying -f argument:
```
docker-compose -f <my_compose_filename>.yaml
```

### Configuration
**NOTE:** The top-level element `version` has been deprecated.



#### Sample compose.yaml

```yaml
version: "3.8"
services:
  db:
    image: mongo
    volumes:
      - type: volume
        source: dbdata
        target: /data/db
      # Alternative syntax
      # - dbdata:/data/db
    # environment:
     #  MONGO_INITDB_ROOT_USERNAME: root
      # MONGO_INITDB_ROOT_PASSWORD: secret
      # Alternative syntax
      # - MONGO_INITDB_ROOT_USERNAME=root
      # - MONGO_INITDB_ROOT_PASSWORD=secret
    # Or specficy environment file
    env_file:
      - ./env/mongo.env
  back:
    build: backend
    ports:
      - 8080:8080
    volumes:
      - type: volume
        source: logs
        target: /app/logs
      - type: bind
        source: ./backend
        target: /app
      - type: volume
        target: /app/node_modules
    env_file: ./env/backend.env
    depends_on:
      - db

  front:
    build: ./frontend
    ports:
      - 80:3000
    volumes:
      - type: volume
        target: /app/node_modules
      - type: bind
        source: frontend
        target: /app
    # stdin_open: true
    # tty: true
    depends_on:
      - back
volumes:
  dbdata:
  logs:
```
