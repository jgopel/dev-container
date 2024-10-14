#!/bin/bash

set -euo pipefail

CONTAINER_NAME=dev-container

if docker inspect "${CONTAINER_NAME}" > /dev/null 2>&1; then
    if docker inspect -f '{{.State.Status}}' "${CONTAINER_NAME}" | grep -q "running"; then
        echo "Attaching to ${CONTAINER_NAME}"
    else
        echo "Starting ${CONTAINER_NAME}"
        ./start-container.sh "$1" --detach --name "${CONTAINER_NAME}"
    fi
else
    echo "Starting ${CONTAINER_NAME}"
    ./start-container.sh "$1" --detach --name "${CONTAINER_NAME}"
fi
docker exec -it "${CONTAINER_NAME}" bash
