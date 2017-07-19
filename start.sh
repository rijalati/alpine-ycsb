#!/usr/bin/env mksh

typeset -r progname="${ basename "${0}"; }"

function usage
{

    BOLD="\e[1m"
    NORM="\e[0m"

    cat <<EOF
${ print "${BOLD}NAME${NORM}"; }
  ${progname} - starts YCSB workloads against noSQL dbs.

${ print "${BOLD}DESCRIPTION${NORM}"; }
  ${progname} runs workloads against noSQL DBs, can be used as a docker
entrypoint or stand alone.

${ print "${BOLD}OPTIONS${NORM}"; }
-f <FQDN> fqdn of node(s) to target, if providing more than 1 separate entries
with commas, no spaces.

-w <workload> workload to run, currently only supports pre-defined workloads, a-f.

-r <records> number of records to load, defaults to 1000000

-o <ops> number of operations to perform, defaults to 5000000

-t <target> type of database/datastore being targeted.

${ print "${BOLD}IMPLEMENTATION${NORM}"; }
  version         ${progname} (Blue Medora Inc.) v1.0
  author          Ritchie J Latimore <ritchie.latimore@bluemedora.com>
  copyright       Copyright (c) 2016 Blue Medora Inc.

EOF

    exit 2
}

### TRAPS

trap 'print "\n${progname} has finished\n"' EXIT

### FUNCTIONS

function fatal_error
{
    print -u2 -n "${progname}: "
    print -u2 -f %q "$@"
    exit 1
}

function config_workloads
{
    sed -i "s/recordcount=1000/recordcount=${records:=1000000}/g" \
        /opt/ycsb-*/workloads/workload*
    sed -i "s/operationcount=1000/operationcount=${ops:=5000000}/g" \
        /opt/ycsb-*/workloads/workload*

    return
}

function load_data
{
    if [[ ! -e /.loaded_data ]]; then

        /opt/ycsb-*/bin/ycsb.sh load ${target} -s -P workloads/workload${workload} && touch /.loaded_data
    fi

    return
}

