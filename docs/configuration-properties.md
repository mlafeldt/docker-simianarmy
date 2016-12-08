# Configuration Properties

What follows is an overview of all configuration properties you can set. See [Configuration](configuration.md) on how to pass properties to the Docker image.

Properties marked with an asterisk (\*) are custom properties added by this Docker image to simplify configuration, e.g. to avoid having to configure long Java class names.

## Client Properties

| Key | Default |
| --- | ------- |
| /simianarmy/client/aws/accountkey | |
| /simianarmy/client/aws/secretkey | |
| /simianarmy/client/aws/region | |
| /simianarmy/client/aws/assumerolearn | |
| /simianarmy/client/aws/accountname | |
| /simianarmy/client/aws/proxyhost | |
| /simianarmy/client/aws/proxyport | |
| /simianarmy/client/aws/proxyuser | |
| /simianarmy/client/aws/proxypassword | |
| /simianarmy/client/localdb/enabled\* | false |
| /simianarmy/client/cloudformationmode/enabled\* | false |

See https://github.com/Netflix/SimianArmy/wiki/Client-Settings for a detailed description of the properties.

## Global Properties

| Key | Default |
| --- | ------- |
| /simianarmy/recorder/sdb/domain | |
| /simianarmy/recorder/localdb/file | |
| /simianarmy/recorder/localdb/maxevents | |
| /simianarmy/recorder/localdb/password | |
| /simianarmy/scheduler/frequency | 1 |
| /simianarmy/scheduler/frequencyunit | HOURS |
| /simianarmy/scheduler/threads | 1 |
| /simianarmy/calendar/openhour | 9 |
| /simianarmy/calendar/closehour | 15 |
| /simianarmy/calendar/timezone | America/Los_Angeles |
| /simianarmy/calendar/ismonkeytime | false |
| /simianarmy/tags/owner | |
| /simianarmy/aws/email/region | |

See https://github.com/Netflix/SimianArmy/wiki/Global-Settings for a detailed description of the properties.

## Chaos Monkey Properties

| Key | Default |
| --- | ------- |
| /simianarmy/chaos/enabled | true |
| /simianarmy/chaos/leashed | true |
| /simianarmy/chaos/burnmoney | false |
| /simianarmy/chaos/terminateondemand/enabled | false |
| /simianarmy/chaos/mandatorytermination/enabled | false |
| /simianarmy/chaos/mandatorytermination/windowindays | |
| /simianarmy/chaos/mandatorytermination/defaultprobability | |
| /simianarmy/chaos/asg/enabled | false |
| /simianarmy/chaos/asg/probability | 1.0 |
| /simianarmy/chaos/asg/maxterminationsperday | 1.0 |
| /simianarmy/chaos/asgtag/key | |
| /simianarmy/chaos/asgtag/value | |
| /simianarmy/chaos/shutdowninstance/enabled | true |
| /simianarmy/chaos/blockallnetworktraffic/enabled | false |
| /simianarmy/chaos/detachvolumes/enabled | false |
| /simianarmy/chaos/burncpu/enabled | false |
| /simianarmy/chaos/burnio/enabled | false |
| /simianarmy/chaos/killprocesses/enabled | false |
| /simianarmy/chaos/nullroute/enabled | false |
| /simianarmy/chaos/failec2/enabled | false |
| /simianarmy/chaos/faildns/enabled | false |
| /simianarmy/chaos/faildynamodb/enabled | false |
| /simianarmy/chaos/fails3/enabled | false |
| /simianarmy/chaos/filldisk/enabled | false |
| /simianarmy/chaos/networkcorruption/enabled | false |
| /simianarmy/chaos/networklatency/enabled | false |
| /simianarmy/chaos/networkloss/enabled | false |
| /simianarmy/chaos/notification/global/enabled | false |
| /simianarmy/chaos/notification/sourceemail | |
| /simianarmy/chaos/notification/receiveremail | |

See https://github.com/Netflix/SimianArmy/wiki/Chaos-Settings for a detailed description of the properties. Also, consult https://github.com/Netflix/SimianArmy/wiki/The-Chaos-Monkey-Army to learn more about the different Chaos Monkey strategies.

## Janitor Monkey Properties

| Key | Default |
| --- | ------- |
| simianarmy/janitor/enabled | true
| simianarmy/janitor/leashed | true
| simianarmy/janitor/resources/sdb/domain | SIMIAN_ARMY
| simianarmy/calendar/isMonkeyTime | <not set> |
| simianarmy/janitor/enabledResources | Instance, ASG, EBS_Volume, EBS_Snapshot, Launch_Config
| simianarmy/janitor/notification/sourceEmail | foo@bar/com
| simianarmy/janitor/summaryEmail/to | foo@bar/com
| simianarmy/janitor/notification/defaultEmail | foo@bar/com
| simianarmy/janitor/notification/daysBeforeTermination | 2
| simianarmy/janitor/snapshots/ownerId | <not set> |
| simianarmy/janitor/rule/orphanedInstanceRule/enabled | true
| simianarmy/janitor/rule/orphanedInstanceRule/instanceAgeThreshold | 2
| simianarmy/janitor/rule/orphanedInstanceRule/retentionDaysWithOwner | 3
| simianarmy/janitor/rule/orphanedInstanceRule/retentionDaysWithoutOwner | 8
| simianarmy/janitor/rule/orphanedInstanceRule/opsworks/parentage | false
| simianarmy/janitor/rule/untaggedRule/enabled | false
| simianarmy/janitor/rule/untaggedRule/requiredTags | owner, purpose, project
| simianarmy/janitor/rule/untaggedRule/resources | Instance, ASG, EBS_Volume, EBS_Snapshot
| simianarmy/janitor/rule/untaggedRule/retentionDaysWithOwner | 2
| simianarmy/janitor/rule/untaggedRule/retentionDaysWithoutOwner | 2
| simianarmy/janitor/rule/oldDetachedVolumeRule/enabled | true
| simianarmy/janitor/rule/oldDetachedVolumeRule/detachDaysThreshold | 30
| simianarmy/janitor/rule/oldDetachedVolumeRule/retentionDays | 7
| simianarmy/janitor/rule/deleteOnTerminationRule/enabled | true
| simianarmy/janitor/rule/deleteOnTerminationRule/retentionDays | 3
| simianarmy/janitor/rule/noGeneratedAMIRule/enabled | true
| simianarmy/janitor/rule/noGeneratedAMIRule/ageThreshold | 30
| simianarmy/janitor/rule/noGeneratedAMIRule/retentionDays | 7
| simianarmy/janitor/rule/oldEmptyASGRule/enabled | true
| simianarmy/janitor/rule/oldEmptyASGRule/launchConfigAgeThreshold | 50
| simianarmy/janitor/rule/oldEmptyASGRule/retentionDays | 10
| simianarmy/janitor/rule/suspendedASGRule/enabled | true
| simianarmy/janitor/rule/suspendedASGRule/suspensionAgeThreshold | 2
| simianarmy/janitor/rule/suspendedASGRule/retentionDays | 5
| simianarmy/janitor/Eureka/enabled | false
| simianarmy/janitor/rule/oldUnusedLaunchConfigRule/enabled | true
| simianarmy/janitor/rule/oldUnusedLaunchConfigRule/ageThreshold | 4
| simianarmy/janitor/rule/oldUnusedLaunchConfigRule/retentionDays | 3
| simianarmy/janitor/image/crawler/lookBackDays | 60
| simianarmy/janitor/image/ownerId | <not set> |
| simianarmy/janitor/rule/unusedImageRule/enabled | false
| simianarmy/janitor/rule/unusedImageRule/lastReferenceDaysThreshold | 45
| simianarmy/janitor/rule/unusedImageRule/retentionDays | 3
| simianarmy/janitor/edda/enabled | <not set> |
| simianarmy/janitor/edda/endpoint/useast1 | <not set> |
| simianarmy/janitor/edda/client/timeout | <not set> |
| simianarmy/janitor/edda/client/retries | <not set> |
| simianarmy/janitor/edda/client/retryInterval | <not set> |
| simianarmy/janitor/notification/ownerEmailDomain | <not set> |

See https://github.com/Netflix/SimianArmy/wiki/Janitor-Settings for a detailed description of the properties.

*NOTE*: In order to use JanitorMonkey to clean up AMIs, it requires [Edda](https://github.com/Netflix/edda) to be installed and configured.

## Conformity Monkey Properties

Conformity Monkey is disabled and cannot be configured at the moment.

## VolumeTagging Monkey Properties

VolumeTagging Monkey is disabled and cannot be configured at the moment.
