# REST API

Chaos Monkey provides a [REST API](https://github.com/Netflix/SimianArmy/wiki/REST) that can be used to trigger and retrieve chaos events.

In order to trigger chaos events via the API, you need to define the following configuration properties:

| Key | Value |
| --- | ----- |
| /simianarmy/chaos/leashed | Must be `false` to unleash the monkey |
| /simianarmy/chaos/terminateondemand/enabled | Must be `true` to enable on-demand termination |

# Client

[chaosmonkey](https://github.com/mlafeldt/chaosmonkey) provides both a Go library and a command-line tool to talk to the Chaos Monkey REST API.
