#!/bin/sh

set -e

# Configure Simian Army
confd -onetime ${CONFD_OPTS:-"-backend=env"}

# Execute any debugging commands, e.g. "/bin/bash" to get a login shell
if test $# -ge 1; then
    exec "$@"
fi

# Start Simian Army
exec ./gradlew jettyRun --no-daemon
