resource "aws_iam_role" "chatbot" {
  name               = "chatbot"
  assume_role_policy = data.aws_iam_policy_document.chatbot.json
}

data "aws_iam_policy_document" "chatbot" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["chatbot.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "chatbot_additional" {
  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "chatbot_additional" {
  name   = "chatbot-additional-policy"
  policy = data.aws_iam_policy_document.chatbot_additional.json
}

resource "aws_iam_role_policy_attachment" "chatbot_additional" {
  role       = aws_iam_role.chatbot.name
  policy_arn = aws_iam_policy.chatbot_additional.arn
}
