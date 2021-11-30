data "aws_acm_certificate" "this" {
  domain = "tf.example.com"
  types  = ["AMAZON_ISSUED"]
}
