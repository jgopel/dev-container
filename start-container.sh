#!/bin/bash

set -euo pipefail

SERVICE="${1:-user}"

USERNAME=$(whoami)
export USERNAME
USER_ID=$(id -u)
export USER_ID
DEFAULT_GROUP_ID=$(id -g)
export DEFAULT_GROUP_ID
DOCKER_GROUP_ID=$(getent group docker | cut -d: -f3)
export DOCKER_GROUP_ID
SUDO_GROUP_ID=$(getent group sudo | cut -d: -f3)
export SUDO_GROUP_ID

docker compose run --rm --remove-orphans --build "${@:2}" "${SERVICE}"
