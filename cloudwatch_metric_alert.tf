/*
  CloudWatch MetricsからACMの残り日数を取得できるため、これをトリガーにしてslack通知している
  see:
    - https://aws.amazon.com/jp/about-aws/whats-new/2021/03/aws-certificate-manager-provides-certificate-expiry-monitoring-through-amazon-cloudwatch/
    - https://dev.classmethod.jp/articles/acm-certificate-expiry-monitoring-cloudwatch/
*/
resource "aws_cloudwatch_metric_alarm" "days_to_expiry" {
  for_each = local.acms

  alarm_name          = "acm-expiry-is-coming-on-${each.value.domain}"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  datapoints_to_alarm = "1"
  metric_name         = "DaysToExpiry"
  namespace           = "AWS/CertificateManager"
  period              = "86400" # 最大が1日のため86400sec(1日)を指定している
  statistic           = "Minimum"
  # 更新日の約60日前から対応できるらしいので、それに合わせて発火するようにしている
  # see: https://aws.amazon.com/jp/premiumsupport/knowledge-center/certificate-fails-to-auto-renew/
  threshold         = "60"
  alarm_description = "ACM (${each.value.domain}) Expiry is coming. Please update ACM from AWS Managed Console."
  alarm_actions     = [aws_sns_topic.acm_expiry_notification.arn]
  # see: https://docs.aws.amazon.com/acm/latest/userguide/cloudwatch-metrics.html
  dimensions = {
    CertificateArn = data.aws_acm_certificate.this[each.key].arn
  }
}
