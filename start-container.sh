#!/bin/bash

set -euo pipefail

USERNAME=$(whoami)
USER_ID=$(id -u)
GROUP_ID=$(id -g)

docker compose run --rm --remove-orphans --build \
    --volume "${HOME}":/home/"${USERNAME}" --workdir "${HOME}" \
    --user "${USER_ID}":"${GROUP_ID}" \
    --env TERM="${TERM}" "${@:2}" "$1"
