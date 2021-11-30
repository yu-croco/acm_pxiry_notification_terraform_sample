resource "aws_cloudwatch_metric_alarm" "days_to_expiry" {
  alarm_name          = "acm-expiry-is-coming-on-${data.aws_acm_certificate.this.domain}"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  datapoints_to_alarm = "1"
  metric_name         = "DaysToExpiry"
  namespace           = "AWS/CertificateManager"
  # 86400sec = one day
  # CloudWatch Metrics gets update once a day against this metrics, so follow the span.
  period    = "86400"
  statistic = "Minimum"
  # ACM can be updated around 60 days before
  threshold         = "60"
  alarm_description = "ACM (${data.aws_acm_certificate.this.domain}) Expiry is coming. Please update ACM from AWS Managed Console."
  alarm_actions     = [aws_sns_topic.acm_expiry_notification.arn]
  # see: https://docs.aws.amazon.com/acm/latest/userguide/cloudwatch-metrics.html
  dimensions = {
    CertificateArn = data.aws_acm_certificate.this.arn
  }
}
