#!/bin/bash

# TODO: make these come from args
RCON_PASSWORD="CHANGEME_321gfda"
L4D2_HOSTNAME="CHANGEME"
STEAMGROUP_ID="CHANGEME"

PORT=$1
DOCKER_TAG=$2
FORCE_RESTART=$3

####

if [[ -z ${PORT} ]]; then
    echo "enter the PORT"
    exit 1
fi

if [[ -z ${DOCKER_TAG} ]]; then
    echo "enter the DOCKER_TAG"
    exit 1
fi

if [[ -z ${} ]]; then
    echo "enter the RCON_PASSWORD"
    exit 1
fi

if [[ "${PORT}" == "27015" ]] || [[ "${PORT}" == "27016" ]]; then
    GAMETYPES="versus"
else
    GAMETYPES="coop,realism,survival,versus,teamversus,scavenge,teamscavenge"
fi

####

container_name="l4d2-${PORT}"
container_image="l4d2:${DOCKER_TAG}"


if [[ "${FORCE_RESTART}" == "true"  ]]; then
    docker stop "${container_name}"
    docker rm "${container_name}"
fi

docker run \
    -e STEAMGROUP=${STEAMGROUP_ID} \
    -e HOSTNAME="${L4D2_HOSTNAME}" \
    -e REGION=5 \
    -e RCON_PASSWORD=${RCON_PASSWORD} \
    -e MAP_NAME="c1m1_hotel" \
    -e PORT=${PORT} \
    -e GAMETYPES=${GAMETYPES} \
    -p ${PORT}:${PORT}/tcp \
    -p ${PORT}:${PORT}/udp \
    --net=host \
    --restart always \
    --name ${container_name} \
    -d \
    ${container_image}
