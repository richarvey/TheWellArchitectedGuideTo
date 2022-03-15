locals {
  bucket_name = "${var.bucket_name}-${random_pet.this.id}"
}

resource "random_pet" "this" {
  length = 3
}

resource "aws_iam_role" "this" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.this.arn]
    }

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${local.bucket_name}",
    ]
  }
}

module "s3_bucket" {
    source = "terraform-aws-modules/s3-bucket/aws"
    bucket = local.bucket_name 
    acl = "${var.acl_value}"
    force_destroy = true

    attach_policy = true
    policy        = data.aws_iam_policy_document.bucket_policy.json

    tags = {
      Name = local.bucket_name
      Project = "${var.project}"
      Environment = "${var.env}"
      Owner = "${var.owner}"
      CostCenter = "${var.cost}"
      Confidentiality = "${var.conf}"
    }
    
    versioning = {
      enabled = "${var.versioning}"
    }

}
