provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  backend "s3" {
    bucket = "sctp-ce8-tfstate"
    key    = "tschui-s3-tf-ci.tfstate" #Change this
    region = "ap-southeast-1"
  }
}

data "aws_caller_identity" "current" {}

locals {
  # name_prefix = "${split("/", "${data.aws_caller_identity.current.arn}")[1]}"
  # account_id  = "${data.aws_caller_identity.current.account_id}"
  name_prefix = split("/", data.aws_caller_identity.current.arn)[1]
  account_id  = data.aws_caller_identity.current.account_id
}

resource "aws_s3_bucket" "s3_tf" {
  #checkov:skip=CKV2_AWS_62:Ensure
  #checkov:skip=CKV_AWS_21:Ensure
  #checkov:skip=CKV2_AWS_6:Ensure
  #checkov:skip=CKV_AWS_18:Ensure
  #checkov:skip=CKV_AWS_144:Ensure
  #checkov:skip=CKV_AWS_145:Ensure
  #checkov:skip=CKV2_AWS_61:Ensure
  bucket = "${local.name_prefix}-s3-tf-bkt-${local.account_id}"
}

terraform {
  required_version = ">= 1.10.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}