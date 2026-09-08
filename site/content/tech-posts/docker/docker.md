+++
date = '2026-02-27T11:51:52Z'
draft = false
title = 'Docker'
+++

### CentOS repo

`# dnf config-manager --add-repo `[`https://download.docker.com/linux/centos/docker-ce.repo`](https://download.docker.com/linux/centos/docker-ce.repo)

### Prerequisites

`lvm2`  
`device-mapper-persistent-data`

### Installation

`# dnf install -y docker-ce-18.09.5 docker-ce-cli-18.09.5 containerd.io`

### Test installation

`# docker info`

Note: user executing command must be a member of the **docker** system
group.

### Making changes to the docker daemon

This can be achieved either through editing the **ExecStart** directive
in the unit file (not recommended) or creating/editing
**/etc/docker/daemon.json**

An example: Changing the storage driver

`# cat /etc/docker/daemon.json`  
`{`  
`  "storage-driver": "devicemapper"`  
`}`

`# systemctl restart docker`

### Docker Swarm

To initialise:

`# docker swarm init --advertise-addr <IP address>`

This will print out a token and **join** command for nodes to join the
swarm. Example below:

`Swarm initialized: current node (323xu2ss1qckyhc1429uzqxoo) is now a manager.`  
`To add a worker to this swarm, run the following command:`  
  
`   docker swarm join --token SWMTKN-1-57qyry6sy9wuv8gonf1h69vqmp0z4lhwv64ng48rn63cctcj0e-c4hcdja8hbfnyrrslf1kitred 172.31.100.31:2377`  
  
`To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.`

This token/command can also be displayed by entering the following
command:

`docker swarm join-token worker`  
`To add a worker to this swarm, run the following command:`  
  
`    docker swarm join --token SWMTKN-1-57qyry6sy9wuv8gonf1h69vqmp0z4lhwv64ng48rn63cctcj0e-c4hcdja8hbfnyrrslf1kitred 172.31.119.142:2377`

Then execute this command on each node

`$ docker swarm join --token SWMTKN-1-57qyry6sy9wuv8gonf1h69vqmp0z4lhwv64ng48rn63cctcj0e-c4hcdja8hbfnyrrslf1kitred 172.31.119.142:2377`  
`This node joined a swarm as a worker.`

On the swarm manager you can then display the swarm nodes as follows

`$ docker node ls`  
`ID                            HOSTNAME                       STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION`  
`sf2j44p2bq6c2yye5poxcbmcc     3469f908f21c.mylabserver.com   Ready     Active                          20.10.5`  
`hk98uejkm9n6f2jc9vtx185vh     5200fc1dfa1c.mylabserver.com   Ready     Active                          20.10.5 `  
`kzic0ccrvm0t8ixbc6x9r55ca *   e132872fcb1c.mylabserver.com   Ready     Active         Leader           20.10.5`

To leave the swarm, execute the following command on the node

`$ docker swarm leave`  
`Node left the swarm.`

To force a manager to leave the swarm, execute

`$ docker swarm leave --force`  
`Node left the swarm.`
  
  
  
### Backup/Restore

On the swarm manager, all swarm configuration is held in the
**/var/lib/docker/swarm** directory

`# find /var/lib/docker/swarm/`  
`/var/lib/docker/swarm/`  
`/var/lib/docker/swarm/docker-state.json`  
`/var/lib/docker/swarm/certificates`  
`/var/lib/docker/swarm/certificates/swarm-root-ca.crt`  
`/var/lib/docker/swarm/certificates/swarm-node.key`  
`/var/lib/docker/swarm/certificates/swarm-node.crt`  
`/var/lib/docker/swarm/worker`  
`/var/lib/docker/swarm/worker/tasks.db`  
`/var/lib/docker/swarm/raft`  
`/var/lib/docker/swarm/raft/snap-v3-encrypted`  
`/var/lib/docker/swarm/raft/wal-v3-encrypted`  
`/var/lib/docker/swarm/raft/wal-v3-encrypted/0000000000000000-0000000000000000.wal`  
`/var/lib/docker/swarm/raft/wal-v3-encrypted/0.tmp`  
`/var/lib/docker/swarm/state.json`

Backup can be achieved by simply archiving the directory as below:

`# systemctl stop docker`  
`# cd /var/lib/docker`  
`# tar czvf /tmp/myDockerSwarmBackup.tgz swarm`  
`# systemcl start docker`

Restore is achieved with a similar procedure:

`# systemctl stop docker`  
`# cd /var/lib/docker`  
`# rm -rf swarm`  
`# tar -xvf /tmp/myDockerSwarmBackup.tgz`  
`# systemcl start docker`

### Dockerfiles

- Named **Dockerfile** with an uppercase **D**
- Start with the **FROM** directive, which defines the base layer
- Variables defined with the **ENV** directive may be referenced in the
  Dockerfile and in the runtime container
- The **RUN** directive defines a native command to execute in the
  runtime container. Any modifications this make to the layered
  filesystem are committed to a new layer
- The **CMD** directive, defines a default command to be executed in the
  runtime container, if no command is defined on the command line when
  docker is invoked
- **EXPOSE** documents which port are intended for publication, it does
  NOT actually publish the port
- **WORKDIR** sets the current directory during your container build.
  Can be absolute or relative. Can have multiple directives. Last
  directive will be the container's runtime working directory. Will create the directory if it does not existx
- **COPY** copies a file from your build directory to your container
  working directory
- **ADD** similar to copy but can reference, amongst others, URLs and
  archives
- **STOPSIGNAL** specifies the termination signal sent to the container
  process after a container is stopped
- **HEALTHCHECK** specifies a command to execute to determine if the
  container running as expected. Options are specified to tell Docker
  what to do based on the result

### Building a Docker image

Syntax:

`# docker build -t <tag> <build directory>`

Example:

`docker build -t myTag .`
