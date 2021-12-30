variable "bucket_name" {
    default = "sqcows-demo-bucket"
}

variable "acl_value" {
    default = "private"
}

variable "origin_region" {
    default = "eu-west-1"
}

variable "replica_region" {
    default = "eu-central-1"
}

variable "versioning" {
    default = "true"
}

variable "project" {
    default = "thewellarchguide"
}

variable "env" {
    default = "demo"
}

variable "owner" {
    default = "Ric Harvey"
}

variable "cost" {
    default = "The Book Team"
}

variable "conf" {
    default = "creative commons"
}
