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

  default_space_jupyter_lab_app_settings = {
    app_lifecycle_management = {
      idle_settings = {
        idle_timeout_in_minutes     = 60
        lifecycle_management        = "ENABLED"
        max_idle_timeout_in_minutes = 60
        min_idle_timeout_in_minutes = 60
      }
    }

    default_resource_spec = {
      instance_type = "ml.t3.medium"
    }
  }

  default_user_code_editor_app_settings = {
    app_lifecycle_management = {
      idle_settings = {
        idle_timeout_in_minutes     = 60
        lifecycle_management        = "ENABLED"
        max_idle_timeout_in_minutes = 60
        min_idle_timeout_in_minutes = 60
      }
    }

    default_resource_spec = {
      instance_type = "ml.t3.medium"
    }
  }

  default_user_jupyter_lab_app_settings = {
    app_lifecycle_management = {
      idle_settings = {
        idle_timeout_in_minutes     = 60
        lifecycle_management        = "ENABLED"
        max_idle_timeout_in_minutes = 60
        min_idle_timeout_in_minutes = 60
      }
    }

    default_resource_spec = {
      instance_type = "ml.t3.medium"
    }
  }

  user_profiles = [
    "user-1",
    "user-2",
  ]
}
