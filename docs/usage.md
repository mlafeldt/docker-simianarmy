## Usage

This will start a Docker container running the Simian Army:

```bash
docker pull mlafeldt/simianarmy
docker run -it --rm [-e CONFD_OPTS="..."] mlafeldt/simianarmy
```

See [Configuration](configuration.md) on how to configure the Simian Army.

## REST API

If you want to access Simian Army's [REST API](https://github.com/Netflix/SimianArmy/wiki/REST), you additionally need to expose port 8080 like this:

```bash
docker run -it --rm -p 8080:8080 mlafeldt/simianarmy
```

## Troubleshooting

This will drop you into a login shell, which is useful for debugging:

```bash
docker run -it --rm mlafeldt/simianarmy /bin/bash
```

In general, the image will execute any command you pass on the command line.
