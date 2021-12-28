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

resource "aws_kms_key" "objects" {
  description             = "KMS key is used to encrypt bucket objects"
  deletion_window_in_days = 7
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

    # S3 bucket-level Public Access Block configuration
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true

    server_side_encryption_configuration = {
      rule = {
        apply_server_side_encryption_by_default = {
          kms_master_key_id = aws_kms_key.objects.arn
          sse_algorithm     = "aws:kms"
        }
      }
    }

}

resource "aws_s3_bucket_object" "examplebucket_object" {
  depends_on = [ module.s3_bucket.s3_bucket_arn ]
  key                    = "someobject"
  bucket                 = local.bucket_name
  source                 = "index.html"
}
