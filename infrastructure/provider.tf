provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    bucket = "sbtk-tfstate"
    key = "aws-app-mesh-examples/aws-app-mesh-examples.tf"
    region = "ap-northeast-1"
  }
}
