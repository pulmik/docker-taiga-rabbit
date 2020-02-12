#!/bin/sh

exec docker-entrypoint.sh rabbitmq-server &
ENTRYPOINT_PID=$!

trap 'kill -TERM $ENTRYPOINT_PID' SIGTERM

RABBIT_INITIALIZED_LOCK=/run/rabbit_initialized.lock
if [ ! -f $RABBIT_INITIALIZED_LOCK ]; then
    touch $RABBIT_INITIALIZED_LOCK

    echo 'Waiting for rabbitmq to start...'
    ok=1
    while [ $ok -gt 0 ]; do
        sleep 1
        rabbit_pid=$(ls -1 /var/lib/rabbitmq/mnesia/rabbit*.pid)
        ok=$?
    done
    rabbitmqctl wait $rabbit_pid

    echo 'Initializing rabbitmq vhost and user...'
    rabbitmqctl add_user $RABBIT_USER $RABBIT_PASSWORD
    rabbitmqctl add_vhost $RABBIT_VHOST
    rabbitmqctl set_permissions -p $RABBIT_VHOST $RABBIT_USER ".*" ".*" ".*"
fi

wait $ENTRYPOINT_PID
