# ACM Expiry Notification Terraform Sample

You cannot update ACM automatically, so this resource alerts that the expiry is coming before 2 month of expiry.
The resource alerts via `CloudWatch Metrics` -> `SNS` -> `Chatbot` -> `Slack通知(#dev_infra)` .
