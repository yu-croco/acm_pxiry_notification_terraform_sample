/*
  * 現状ではchatbot関連のリソースはTerraformでサポートされていないため、AWSが出しているTerraform moduleを利用する
  * see:
  *   - https://github.com/hashicorp/terraform-provider-aws/issues/12304
  *   - https://registry.terraform.io/modules/waveaccounting/chatbot-slack-configuration/aws/latest
*/

module "chatbot_slack_configuration" {
  source  = "waveaccounting/chatbot-slack-configuration/aws"
  version = "1.0.0"

  configuration_name = "acm-expiry-is-comming"
  logging_level      = "INFO"
  iam_role_arn       = data.aws_iam_role.chatbot.arn
  slack_channel_id   = "C01DTBRDKT3" # dev_infra
  slack_workspace_id = "TD3SM3NDB"   # esite
  sns_topic_arns     = [aws_sns_topic.acm_expiry_notification.arn]
}
