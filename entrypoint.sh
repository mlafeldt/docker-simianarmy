#!/bin/sh
set -e
confd -onetime ${CONFD_OPTS:-"-backend=env"}
if test $# -ge 1; then
    exec "$@"
fi
exec ./gradlew jettyRun
