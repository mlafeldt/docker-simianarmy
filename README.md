# The Simian Army - Docker Edition

This project provides a highly configurable Docker image of the [Simian Army](https://github.com/Netflix/SimianArmy) as a sound basis for [automating chaos experiments](https://medium.com/production-ready/chaos-monkey-for-fun-and-profit-87e2f343db31).

> The Simian Army is a suite of tools for keeping your cloud operating in top form. Chaos Monkey, the first member, is a resiliency tool that helps ensure that your applications can tolerate random instance failures

## Quick Start

As an example, this command will start a Docker container running the Simian Army and instruct Chaos Monkey to consider all auto scaling groups (ASGs) in the given AWS account for termination:

```bash
docker run -it --rm \
    -e SIMIANARMY_CLIENT_AWS_ACCOUNTKEY=$AWS_ACCESS_KEY_ID \
    -e SIMIANARMY_CLIENT_AWS_SECRETKEY=$AWS_SECRET_ACCESS_KEY \
    -e SIMIANARMY_CLIENT_AWS_REGION=$AWS_REGION \
    -e SIMIANARMY_CALENDAR_ISMONKEYTIME=true \
    -e SIMIANARMY_CHAOS_ASG_ENABLED=true \
    mlafeldt/simianarmy
```

This example is safe to run as Chaos Monkey will operate in dry-run mode by default. It's a good way for getting a feeling of the application without taking a risk.

The second example is more realistic. This time, Chaos Monkey will randomly terminate instances of the auto scaling groups tagged with a specific key-value pair:

```bash
docker run -it --rm \
    -e SIMIANARMY_CLIENT_AWS_ACCOUNTKEY=$AWS_ACCESS_KEY_ID \
    -e SIMIANARMY_CLIENT_AWS_SECRETKEY=$AWS_SECRET_ACCESS_KEY \
    -e SIMIANARMY_CLIENT_AWS_REGION=$AWS_REGION \
    -e SIMIANARMY_CALENDAR_ISMONKEYTIME=true \
    -e SIMIANARMY_CHAOS_ASG_ENABLED=true \
    -e SIMIANARMY_CHAOS_ASGTAG_KEY=chaos_monkey \
    -e SIMIANARMY_CHAOS_ASGTAG_VALUE=true \
    -e SIMIANARMY_CHAOS_LEASHED=false \
    mlafeldt/simianarmy
```

Note that this command will actually *unleash* the monkey. But don't worry: you still need to tag your ASGs accordingly for any instances to be killed.

There are many more configuration settings you can pass to the Docker image, including ones to control frequency, probability, and type of terminations. Also, you can (and should) configure Chaos Monkey to send email notifications about terminations. I encourage you to read the following documentation to learn more.

## Documentation

* [Usage](https://github.com/mlafeldt/docker-simianarmy/blob/master/docs/usage.md)
* [Configuration](https://github.com/mlafeldt/docker-simianarmy/blob/master/docs/configuration.md)
* [Configuration Properties](https://github.com/mlafeldt/docker-simianarmy/blob/master/docs/configuration-properties.md)
* [Notifications](https://github.com/mlafeldt/docker-simianarmy/blob/master/docs/notifications.md)

## Author

This project is being developed by [Mathias Lafeldt](https://twitter.com/mlafeldt).
