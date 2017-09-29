# Configuration

The Simian Army is a Java application that reads [its configuration](https://github.com/Netflix/SimianArmy/wiki/Configuration) from `*.properties` files. The Docker container will update those configuration files dynamically at startup via [confd](https://github.com/kelseyhightower/confd).

confd can fetch configuration data from different key-value stores such as etcd or Vault, or environment variables passed to the container via `-e` (the default behavior). For this abstraction to work, the following mapping is used:

| Example property | Key (etcd, Vault) | Environment variable |
| ---------------- | ----------------- | -------------------- |
| simianarmy.chaos.leashed | /simianarmy/chaos/leashed | SIMIANARMY_CHAOS_LEASHED |
| simianarmy.calendar.isMonkeyTime | /simianarmy/calendar/ismonkeytime | SIMIANARMY_CALENDAR_ISMONKEYTIME |
| ... | ... | ... |

See [Configuration Properties](configuration-properties.md) for a list of all available properties.

## Via Environment Variables

That being said, here is how to configure the Simian Army via environment variables:

```bash
docker run -d \
    -e SIMIANARMY_CLIENT_AWS_ACCOUNTKEY=$AWS_ACCESS_KEY_ID \
    -e SIMIANARMY_CLIENT_AWS_SECRETKEY=$AWS_SECRET_ACCESS_KEY \
    -e SIMIANARMY_CLIENT_AWS_REGION=$AWS_REGION \
    -e SIMIANARMY_CALENDAR_ISMONKEYTIME=true \
    -e SIMIANARMY_CHAOS_ASG_ENABLED=true \
    mlafeldt/simianarmy
```

Note: This example is safe to run as Chaos Monkey will operate in dry-run mode (`SIMIANARMY_CHAOS_LEASHED` is `true` by default).

## Via etcd

The same example using etcd:

```bash
# Write configuration data to etcd
export ETCDCTL_ENDPOINT=http://$YOUR_ETCD_IP:2379
etcdctl set /simianarmy/client/aws/accountkey $AWS_ACCESS_KEY_ID
etcdctl set /simianarmy/client/aws/secretkey $AWS_SECRET_KEY
etcdctl set /simianarmy/client/aws/region $AWS_REGION
etcdctl set /simianarmy/calendar/ismonkeytime true

# Start container using data in etcd
docker run -d \
    -e CONFD_OPTS="-backend=etcd -node=$ETCDCTL_ENDPOINT" \
    mlafeldt/simianarmy
```

As this example shows, you can set `CONFD_OPTS` to pass [any available option](https://github.com/kelseyhightower/confd/blob/master/docs/command-line-flags.md) to confd to switch backends, change the log level, etc.
