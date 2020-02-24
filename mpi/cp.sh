# Copy script to copy a file to all MPI nodes
# Syntax ./cp.sh <filepath>
# files will autmatically be copied to ~/workdir


# check if file passed exists
if [ ! -f "$1" ]; then
  echo "The file \"$1\" does not exist!"
else

  # Create mpi hosts file
  docker ps -q | xargs -n 1 docker inspect --format '{{ .Name }} {{range .NetworkSettings.Networks}} {{.IPAddress}}{{end}}' | sed 's#^/##' | grep "mpi" | sed 's/.*  //' > hosts

  # utilize scp to move file to each container
  for host in $(cat ./hosts)
    do
      ssh-keygen -R $host
      ssh-keyscan -H $host >> ~/.ssh/known_hosts
      scp -i ./ssh/id_rsa.mpi $1 mpirun@$host:/home/mpirun/workdir/;
    done
fi 

