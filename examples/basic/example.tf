locals {
  tags = {
    Environment = "development"
    Stack       = "sagemaker"
  }
}

provider "aws" {
  region = "eu-central-1"
}

module "example_studio" {
  source     = "../../"
  name       = "example-studio"
  subnet_ids = [var.subnet_id]
  vpc_id     = var.vpc_id
  tags       = local.tags

  user_profiles = [
    "user-1",
    "user-2",
  ]
}
