#!/bin/bash

envfile=/etc/autossh-check_mk/${2}

if [ ! -f "${envfile}" ]
 then
        echo "no environment file: ${envfile}"
        exit 1
 fi

source ${envfile}

case $1 in
  start)
  firewall-cmd --direct --add-rule ipv4 nat OUTPUT ${NUM} -p tcp --destination ${ip} --dport 6556 -j DNAT --to-destination 127.0.0.1:${proxyport}
  COMMAND=$1
  ;;
  stop)
  firewall-cmd --direct --remove-rule ipv4 nat OUTPUT ${NUM} -p tcp --destination ${ip} --dport 6556 -j DNAT --to-destination 127.0.0.1:${proxyport}
  ;;
  *)
  exit 1
  ;;
esac

