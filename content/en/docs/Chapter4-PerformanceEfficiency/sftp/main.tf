locals {
  bucket_name = "${var.bucket_name}-${random_pet.this.id}"
}

resource "random_pet" "this" {
  length = 3
}

module "s3_bucket" {
    source = "terraform-aws-modules/s3-bucket/aws"
    bucket = local.bucket_name 
    acl = "${var.acl_value}"
    force_destroy = true


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

resource "aws_transfer_server" "example" {
  security_policy_name = "TransferSecurityPolicy-2020-06"
  tags = {
      Name = local.bucket_name
      Project = "${var.project}"
      Environment = "${var.env}"
      Owner = "${var.owner}"
      CostCenter = "${var.cost}"
      Confidentiality = "${var.conf}"
  }
}


