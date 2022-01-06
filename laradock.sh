#!/bin/bash

SERVICES="caddy postgres minio mailhog redis php-worker"

if [ "$1" == "up" ] ; then
    docker-compose up -d $SERVICES

elif [ "$1" == "down" ] ; then
    docker-compose down

elif [ "$1" == "restart" ] ; then
    docker-compose restart

elif [ "$1" == "build" ] ; then
    if [ "$#" -gt 1 ] ; then
        shift 1
        docker-compose build "$@"
    else
        docker-compose build $SERVICES
    fi
elif [ "$1" == "artisan" ] ; then
    shift 1
    docker-compose exec \
        workspace \
        php artisan "$@"
elif [ "$1" == "composer" ] ; then
    shift 1
    docker-compose exec \
        workspace \
       composer "$@"
else
    printf "Available options:\n";
    printf "    up\n";
    printf "    down\n";
    printf "    restart\n";
    printf "    build [services]\n";
    printf "    artisan\n";
    printf "    composer\n";
fi
