terraform {
  backend "s3" {
    bucket = "terraform-nilz"
    key    = "ecr-project/terraform.tfstate"
    region = "us-east-2"
  }
}
