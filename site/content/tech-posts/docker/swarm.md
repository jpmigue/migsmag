+++
date = '2026-02-27T13:03:09Z'
draft = true
title = 'Swarm'
+++
# Docker Swarm

Swarm is not enabled by default, to check whether Swarm is enabled on your system, execute:
```sh
$ docker info|grep -i swarm
 Swarm: inactive
 ```

To initialise, execute:
```bash
$ docker swarm init
Swarm initialized: current node (u4uwvpk9or8m2x6keim5fzo3j) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-0iovy5rol7qxvxhf0ea5nhkkn7znbk33wsq56qjmfacyaoeeto-9kg9832br12571mhymzeusd6r 172.19.138.150:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
```

After initialisation, we can check the swarm members with:
```bash
$ docker node ls
ID                            HOSTNAME   STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
u4uwvpk9or8m2x6keim5fzo3j *   xpsfed     Ready     Active         Leader           29.2.1
```


