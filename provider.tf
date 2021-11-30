provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  required_version = "= 1.0.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 3.61.0"
    }
  }
}
