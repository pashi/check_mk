#!/bin/bash

# Author: Pasi Lammi <pasi@pashi.net>
# License: Apache License

# random port for check_mk ssh tunnels
# todo

NAME=${1}
PORT="X"
if [ -f "/var/lib/autossh-check_mk/${NAME}" ]
then
  PORT=$(cat /var/lib/autossh-check_mk/${NAME})
else
  PORT=$(( ( RANDOM % 1000 )  + 16000 ))
  echo ${PORT} > /var/lib/autossh-check_mk/${NAME}
fi

echo ${PORT}
