#!/usr/bin/env bash

set -e

idmod redis "$USER_UID" "$USER_GID" || true
chmod -R +r /etc/redis

if [ $# -ne 0 ]; then
    exec tini -- gosu redis "$@"
fi
