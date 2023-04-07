provider "aws" {
  region = var.region
}
terraform {
  backend "s3" {
    key            = "Natgate-way/terraform.tfstate"
    region         = "us-east-1"
    bucket         = "my-s3-4-snr"
    encrypt        = true
  }
}
