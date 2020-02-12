# MPI Docker

## Citation

Original code/work was produced by oweidner
Forked from [oweidner](https://github.com/oweidner/docker.openmpi)

### Changes

1. `docker-compose.yml` upgraded to `v3`
2. modified ssh configuration to map 2222>22 on mpi_head.
3. created a `workdir` in which students can place python files to be added to containers on build

## Preconfig

This repository provides a default ssh keypair that is used for authentication. You may wish to replace and add in your own key pair instead of the default. The key pair provided is **public knowledge**.

The `workdir` is a good place to put all python scripts as they will be added to all containers.

## Usage

The containers need to be brought up and down everytime changes are made to files in `./workdir`.

```shell

# Bring up containers in detached mode, provide number of nodes
docker-compose up -d --scale mpi_node=4 --build

# Run Benchmark examples (testing only)
docker-compose exec --user mpirun --privileged mpi_head mpirun -n 2 python /home/mpirun/mpi4py_benchmarks/all_tests.py

# Run python file located in workdir
docker-compose exec --user mpirun --privileged mpi_head mpirun -n 2 python /home/mpirun/workdir/helloworld.py

# Bring down containers
docker-compose down
```

## Other Possibilities

Since each instance of the image includes openssh server, ssh access is available. MPI head port maps to localhost:2222, all other nodes do not port forward.

### SSH into MPI_HEAD

The `p` flag specifies the port, and the `i` flag specifies to use the key in `./ssh`.

```
ssh mpirun@127.0.0.1 -p 2222 -i ./ssh/id_rsa.mpi
```

### Get IPs of each MPI node

The following bash command can be used to generate a machine or hosts file for mpi. This is useful for automating scp or ssh functions.

```shell
docker ps -q | xargs -n 1 docker inspect --format '{{ .Name }} {{range .NetworkSettings.Networks}} {{.IPAddress}}{{end}}' | sed 's#^/##' | grep "mpi"
```

### SCP python files into containers

SCP can be used to add files to the containers while they are running. replacing `host1` ... `hostn` with the IP addresses of each container will allow for this operation.

```shell
for h in host1 host2 host3 host4; { scp script.py mpirun@$h:/home/mpirun/workdir/; }
```
