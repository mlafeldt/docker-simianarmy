#!/bin/sh
set -e
confd -onetime -backend=env
exec ./gradlew jettyRun
