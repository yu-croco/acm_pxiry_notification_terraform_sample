/*
  * Terraform resource does not support AWS Chatbot, so use provider's module.
  * see:
  *   - https://github.com/hashicorp/terraform-provider-aws/issues/12304
  *   - https://registry.terraform.io/modules/waveaccounting/chatbot-slack-configuration/aws/latest
*/

module "chatbot_slack_configuration" {
  source  = "waveaccounting/chatbot-slack-configuration/aws"
  version = "1.0.0"

  configuration_name = "acm-expiry-is-comming"
  logging_level      = "INFO"
  iam_role_arn       = aws_iam_role.chatbot.arn
  slack_channel_id   = "YOUR_SLACK_CHANNEL_ID"
  slack_workspace_id = "YOUR_SLACK_WORKSPACE_ID"
  sns_topic_arns     = [aws_sns_topic.acm_expiry_notification.arn]
}
