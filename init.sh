#!/bin/bash -e

function clean ()
{
    if [ -d app ] ; then
        rm -rf app
    fi
}

function clone ()
{
    mkdir app
    git clone git@github.com:largescale-dfss/RPC-server-client.git app/RPC-server-client
    git clone git@github.com:largescale-dfss/distributed-file-system.git app/distributed-file-system
    git clone git@github.com:largescale-dfss/django-file-custom-storage.git app/django-file-custom-storage
    git clone git@github.com:largescale-dfss/manager.git app/manager
    git clone git@github.com:largescale-dfss/concept-demo.git app/concept-demo
}

function process ()
{
    cp app/django-file-custom-storage/customStorage.py app/concept-demo/app/dfss/demo/customStorage.py
    cp app/manager/manager_django_pb2.py app/concept-demo/app/dfss/demo/manager_django_pb2.py
}

function run ()
{
    bash app/manager/startManager.sh &
    PIDS[0]=$!

    trap "kill ${PIDS[*]}" SIGINT

    wait
}

if [ $# -eq 0 ]
  then
    clean
    clone
    process
    run
fi