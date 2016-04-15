# The Simian Army, Docker Edition

The goal of this project is to provide a highly configurable Docker image of Netflix's [Simian Army](https://github.com/Netflix/SimianArmy) as a sound basis for running automated chaos experiments.

> The Simian Army is a suite of tools for keeping your cloud operating in top form. Chaos Monkey, the first member, is a resiliency tool that helps ensure that your applications can tolerate random instance failures

## Usage

This will start a Docker container running the Simian Army:

```bash
docker pull mlafeldt/simianarmy
docker run -it --rm [-e CONFD_OPTS="..."] mlafeldt/simianarmy
```

See next section on how to configure the Simian Army.

## Configuration

The Simian Army is a Java application that reads [its configuration](https://github.com/Netflix/SimianArmy/wiki/Configuration) from `*.properties` files. The Docker container will update those configuration files dynamically at startup via [confd](https://github.com/kelseyhightower/confd).

confd can fetch configuration data from different key-value stores such as etcd or Vault, or environment variables passed to the container via `-e` (the default behavior). For this abstraction to work, the following mapping is used:

| Example property | Key (etcd, Vault) | Environment variable |
| ---------------- | ----------------- | -------------------- |
| simianarmy.chaos.leashed | /simianarmy/chaos/leashed | SIMIANARMY_CHAOS_LEASHED |
| simianarmy.calendar.isMonkeyTime | /simianarmy/calendar/ismonkeytime | SIMIANARMY_CALENDAR_ISMONKEYTIME |
| ... | ... | ... |

### Via Environment Variables

That being said, here is how to configure the Simian Army via environment variables:

```bash
docker run -it --rm \
    -e SIMIANARMY_CLIENT_AWS_ACCOUNTKEY=$AWS_ACCESS_KEY_ID \
    -e SIMIANARMY_CLIENT_AWS_SECRETKEY=$AWS_SECRET_ACCESS_KEY \
    -e SIMIANARMY_CLIENT_AWS_REGION=$AWS_REGION \
    -e SIMIANARMY_CALENDAR_ISMONKEYTIME=true \
    mlafeldt/simianarmy
```

Note: This example is safe to run as Chaos Monkey will operate in dry-run mode
(`SIMIANARMY_CHAOS_LEASHED` is `true` by default).

### Via etcd

The same example using etcd:

```bash
# Write configuration data to etcd
export ETCDCTL_ENDPOINT=http://$YOUR_ETCD_IP:2379
etcdctl set /simianarmy/client/aws/accountkey $AWS_ACCESS_KEY_ID
etcdctl set /simianarmy/client/aws/secretkey $AWS_SECRET_KEY
etcdctl set /simianarmy/client/aws/region $AWS_REGION
etcdctl set /simianarmy/calendar/ismonkeytime true

# Start container using data in etcd
docker run -it --rm \
    -e CONFD_OPTS="-backend=etcd -node=$ETCDCTL_ENDPOINT" \
    mlafeldt/simianarmy
```

As this example shows, you can set `CONFD_OPTS` to pass [any available option](https://github.com/kelseyhightower/confd/blob/master/docs/command-line-flags.md) to confd to switch backends, change the log level, etc.

## Supported Properties

What follows is an overview of all configuration properties you may set.

### Client Properties

| Key | Default |
| --- | ------- |
| /simianarmy/client/aws/accountkey | |
| /simianarmy/client/aws/secretkey | |
| /simianarmy/client/aws/region | us-west-1 |
| /simianarmy/client/aws/accountname | default |
| /simianarmy/client/aws/assumerolearn | |

See https://github.com/Netflix/SimianArmy/wiki/Client-Settings for a detailed description of the properties.

### Global Properties

| Key | Default |
| --- | ------- |
| /simianarmy/recorder/sdb/domain | SIMIAN_ARMY |
| /simianarmy/scheduler/frequency | 1 |
| /simianarmy/scheduler/frequencyunit | HOURS |
| /simianarmy/scheduler/threads | 1 |
| /simianarmy/calendar/openhour | 9 |
| /simianarmy/calendar/closehour | 15 |
| /simianarmy/calendar/timezone | America/Los_Angeles |
| /simianarmy/calendar/ismonkeytime | false |
| /simianarmy/tags/owner | owner |
| /simianarmy/aws/email/region | |

See https://github.com/Netflix/SimianArmy/wiki/Global-Settings for a detailed description of the properties.

### Chaos Monkey Properties

| Key | Default |
| --- | ------- |
| /simianarmy/chaos/enabled | true |
| /simianarmy/chaos/leashed | true |
| /simianarmy/chaos/asg/enabled | false |
| /simianarmy/chaos/asg/probability | 1.0 |
| /simianarmy/chaos/asg/maxterminationsperday | 1.0 |
| /simianarmy/chaos/shutdowninstance/enabled | true |
| /simianarmy/chaos/blockallnetworktraffic/enabled | false |
| /simianarmy/chaos/burncpu/enabled | false |
| /simianarmy/chaos/killprocesses/enabled | false |
| /simianarmy/chaos/nullroute/enabled | false |
| /simianarmy/chaos/failapi/enabled | false |
| /simianarmy/chaos/faildns/enabled | false |
| /simianarmy/chaos/faildynamodb/enabled | false |
| /simianarmy/chaos/fails3/enabled | false |
| /simianarmy/chaos/networkcorruption/enabled | false |
| /simianarmy/chaos/networklatency/enabled | false |
| /simianarmy/chaos/networkloss/enabled | false |
| /simianarmy/chaos/detachvolumes/enabled | false |
| /simianarmy/chaos/burnio/enabled | false |
| /simianarmy/chaos/filldisk/enabled | false |
| /simianarmy/chaos/burnmoney | false |
| /simianarmy/chaos/terminateondemand/enabled | false |
| /simianarmy/chaos/mandatorytermination/enabled | false |
| /simianarmy/chaos/mandatorytermination/windowindays | 32 |
| /simianarmy/chaos/mandatorytermination/defaultprobability | 0.5 |
| /simianarmy/chaos/notification/global/enabled | false |
| /simianarmy/chaos/notification/sourceemail | |
| /simianarmy/chaos/notification/receiveremail | |
| /simianarmy/chaos/asgtag/key | |
| /simianarmy/chaos/asgtag/value | |

See https://github.com/Netflix/SimianArmy/wiki/Chaos-Settings for a detailed description of the properties. Also, consult https://github.com/Netflix/SimianArmy/wiki/The-Chaos-Monkey-Army to learn more about the different Chaos Monkey strategies.

### Janitor Monkey Properties

Janitor Monkey is disabled and cannot be configured at the moment.

### Conformity Monkey Properties

Conformity Monkey is disabled and cannot be configured at the moment.

### VolumeTagging Monkey Properties

VolumeTagging Monkey is disabled and cannot be configured at the moment.

## Author

This project is being developed by [Mathias Lafeldt](https://twitter.com/mlafeldt).
