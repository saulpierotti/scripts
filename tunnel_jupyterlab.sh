#!/bin/bash
# Create an ssh tunnel for linking the jupyter port on a remote machine to a
# local port and open jupyter lab in the remote machine on the correct port

case $# in
0)
    echo "No arguments given. I need at least the ssh server to connect to."
    exit 1
    ;;
1)
    port=9999
    echo "Host has been recognised as $1. Port has not been given so defaulting to $port"
    ;;
2)
    port=$2
    echo "Host has been recognised as $1. Port has been recognised as $port"
    ;;
*)
    echo "Too many arguments given. I need at most the ssh server to connect to
    and the port to use."
    exit 1
    ;;
esac

open_notebook="jupyter-lab --no-browser --port=$port"
close_previous_instances="jupyter-lab list|grep http|cut -d/ -f3|cut -d: -f2\
    |while read port; do jupyter-lab stop $port; done"
remote_command="bash -lc \"$close_previous_instances; $open_notebook\""

ssh -L "$port":localhost:"$port" "$1" "$remote_command"
