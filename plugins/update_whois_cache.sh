#!/bin/bash

F=/etc/check_mk/whois.cnf
CACHEDIR=/tmp/mk_domain_whois_cache
maxage=691200

if [ ! -f ${F} ]
then
    echo "File missing: ${F}"
    exit 0
fi

now=$(date +%s)
mkdir -p ${CACHEDIR}

tmpfile=$(mktemp ${CACHEDIR}.XXXXXXXXXXX)
function finish {
    rm -rf "$tmpfile"
}

trap finish EXIT

function run_whois() {
    whois $1 > ${tmpfile}
    lines=$(wc -l ${tmpfile}|cut -f1 -d ' ')
    if [ "${lines}" -gt 2 ]
    then
        cachefile=${CACHEDIR}/${domain}
        cp ${tmpfile} ${cachefile}
    fi
}

for domain in $(cat ${F}|grep -v ^#)
do
    cachefile=${CACHEDIR}/${domain}
    if [ -f ${cachefile} ]
    then
        ts=$(date -r ${cachefile} +%s)
        age=$((${now} - ${ts}))
        if [ "${age}" -gt "${maxage}" ]
        then
            run_whois ${domain}
        fi
    else
      run_whois ${domain}
    fi
done
