#!/bin/mksh

# maor load
function config_workloads
{
    sed -i "s/recordcount=[0-9]*/recordcount=${RECNUM:=1000000}/g" \
        /opt/ycsb-*/workloads/workload*
    sed -i "s/operationcount=[0-9]*/operationcount=${OPNUM:=5000000}/g" \
        /opt/ycsb-*/workloads/workload*
        
    return
}

function load_data
{
    if [[ ! -e /.loaded_data ]]; then

        /opt/ycsb-*/bin/ycsb.sh load "${DBTYPE} -s -P workloads/workload${WORKLETTER} ${DBARGS}" && touch /.loaded_data
    fi

    return
}

# exit message
trap 'echo "\n${progname} has finished\n"' EXIT

# make sure all the params are set and go.
if [[ -z ${DBTYPE} || -z ${WORKLETTER} || -z ${DBARGS} ]]; then
  echo "Missing params! Exiting"
  exit 1
else
  config_workloads
  if [[ ! -z "${ACTION}" ]]; then
    ./bin/ycsb "${ACTION} ${DBTYPE} -s -P workloads/workload${WORKLETTER} ${DBARGS}"
  else
    load_data
    ./bin/ycsb "run ${DBTYPE} -s -P workloads/workload${WORKLETTER} ${DBARGS}"
  fi
fi
