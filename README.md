# The Simian Army - Docker Edition

This project provides a highly configurable Docker image of the [Simian Army](https://github.com/Netflix/SimianArmy) as a sound basis for automating [chaos experiments](https://medium.com/production-ready/chaos-engineering-101-1103059fae44).

> The Simian Army is a suite of tools for keeping your cloud operating in top form. Chaos Monkey, the first member, is a resiliency tool that helps ensure that your applications can tolerate random instance failures

## Quick Start

This will start the Docker container and configure Chaos Monkey to consider all AWS auto scaling groups for termination:

```bash
docker run -it --rm \
    -e SIMIANARMY_CLIENT_AWS_ACCOUNTKEY=$AWS_ACCESS_KEY_ID \
    -e SIMIANARMY_CLIENT_AWS_SECRETKEY=$AWS_SECRET_ACCESS_KEY \
    -e SIMIANARMY_CLIENT_AWS_REGION=$AWS_REGION \
    -e SIMIANARMY_CALENDAR_ISMONKEYTIME=true \
    -e SIMIANARMY_CHAOS_ASG_ENABLED=true \
    mlafeldt/simianarmy
```

Note: This example is safe to run as Chaos Monkey will operate in dry-run mode (`SIMIANARMY_CHAOS_LEASHED` is `true` by default).

## Documentation

* [Usage](https://github.com/mlafeldt/docker-simianarmy/blob/master/docs/usage.md)
* [Configuration](https://github.com/mlafeldt/docker-simianarmy/blob/master/docs/configuration.md)
* [Configuration Properties](https://github.com/mlafeldt/docker-simianarmy/blob/master/docs/configuration-properties.md)
* [Notifications](https://github.com/mlafeldt/docker-simianarmy/blob/master/docs/notifications.md)

## Author

This project is being developed by [Mathias Lafeldt](https://twitter.com/mlafeldt).
