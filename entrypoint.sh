#!/bin/sh
set -e
confd -onetime -backend=env
if test $# -ge 1; then
    exec "$@"
fi
exec ./gradlew jettyRun
