#!/bin/bash

envfile=/etc/autossh-check_mk/${1}

if [ ! -f "${envfile}" ]
 then
        echo "no environment file: ${envfile}"
        exit 1
 fi

export AUTOSSH_GATETIME=10
source ${envfile}
 exec /usr/bin/autossh -M 0 -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" -N $OPTIONS
