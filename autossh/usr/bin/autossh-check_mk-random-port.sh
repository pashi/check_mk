#!/bin/bash

# Author: Pasi Lammi <pasi@pashi.net>
# License: Apache License

# random port for check_mk ssh tunnels
# todo

NAME=${1}
PORT="X"
F="/var/lib/autossh-check_mk/${NAME}.port"
if [ -f "${F}" ]
then
  PORT=$(cat ${F})
else
  PORT=$(( ( RANDOM % 1000 )  + 16000 ))
  echo ${PORT} > ${F}
fi

echo ${PORT}
