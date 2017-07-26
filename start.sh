#!/bin/mksh

# maor load
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

# exit message
trap 'echo "\n${progname} has finished\n"' EXIT

# make sure all the params are set and go.
if [[ -z ${ACTION} && -z ${DBTYPE} && -z ${WORKLETTER} && -z ${DBARGS} ]]; then
  echo "Missing params! Exiting"
  exit 1
else
  config_workloads
  ./bin/ycsb "${ACTION}" "${DBTYPE}" "-P workloads/workload${WORKLETTER}" "${DBARGS}"
fi
