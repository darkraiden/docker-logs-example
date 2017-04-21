#!/bin/bash

export LOGSTASH_ADDRESS=10.5.0.11

start() {
    printf "Running ELK docker-compose...\n"
    docker-compose -f docker-compose-elk.yml up -d
    printf "Running Web docker-compose...\n"
    docker-compose -f docker-compose-web.yml up -d
    exit 0
}

stop() {
    printf "Stopping ELK docker-compose...\n"
    docker-compose -f docker-compose-elk.yml down
    printf "Stopping Web docker-compose...\n"
    docker-compose -f docker-compose-web.yml down
    exit 0
}

restart() {
    printf "Restarting ELK docker-compose...\n"
    docker-compose -f docker-compose-elk.yml restart
    printf "Restarting Web docker-compose...\n"
    docker-compose -f docker-compose-web.yml restart
    exit 0
}

status() {
    printf "ELK stack status:\n"
    docker-compose -f docker-compose-elk.yml ps
    printf "Web stack status:\n"
    docker-compose -f docker-compose-web.yml ps
    exit 0
}

spam() {
    curl_command="curl 127.0.0.1:8090"
    if [ -z $1 ]
    then
        while :
        do
            $curl_command
            sleep 2
        done
    else
        for i in `seq 1 $1`
        do
            $curl_command
            sleep 2
        done
    fi
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    status)
        status
        ;;
    spam)
        spam $2
        ;;
    *)
        echo $"Usage: $0 {start|stop|restart|spam|status}"
        exit 1
esac
