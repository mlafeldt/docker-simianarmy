# Notifications

Chaos Monkey can send email notifications about terminations of instances and other chaos events. This is helpful to raise awareness that failures are being injected.

To set up notifications, you need to define the following configuration properties:

| Key | Value |
| --- | ----- |
| /simianarmy/chaos/notification/global/enabled | Must be `true` to enable notifications |
| /simianarmy/chaos/notification/sourceemail | Set source email address for sending notifications |
| /simianarmy/chaos/notification/receiveremail | Set recipient email address for notifications |
| /simianarmy/aws/email/region | Optionally configure a different AWS region of SES |

*Both* source and recipient email addresses have to be verified in Amazon Simple Email Service (SES); otherwise SES will refuse to send any emails.

Note that the Docker image doesn't support ASG-specific email notifications, nor does it allow to change the subject or body format of emails.

## Slack

Rather than getting (even more) emails, you might prefer notifications to show up in your chat room. Slack's builtin [email integration](https://get.slack.help/hc/en-us/articles/206819278-Sending-emails-to-Slack) allows you to forward emails from Chaos Monkey to Slack. It doesn't get much easier than this!
