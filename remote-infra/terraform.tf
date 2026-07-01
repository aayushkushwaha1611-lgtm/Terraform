terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket         = "ayush-ki-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "ayush-table"


  }
}
