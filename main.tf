resource "aws_sagemaker_domain" "default" {
  region                        = var.region
  app_network_access_type       = var.app_network_access_type
  app_security_group_management = var.app_security_group_management
  auth_mode                     = var.auth_mode
  domain_name                   = var.name
  kms_key_id                    = var.kms_key_id
  subnet_ids                    = var.subnet_ids
  vpc_id                        = var.vpc_id
  tag_propagation               = var.tag_propagation
  tags                          = var.tags

  default_space_settings {
    execution_role  = var.role_arn != null ? var.role_arn : aws_iam_role.default[0].arn
    security_groups = var.security_groups

    dynamic "jupyter_server_app_settings" {
      for_each = var.jupyter_server_app_settings == null ? { create : true } : {}
      content {
        lifecycle_config_arns = [aws_sagemaker_studio_lifecycle_config.jupyterlab_autoshutdown[0].arn]

        default_resource_spec {
          instance_type        = "system"
          lifecycle_config_arn = aws_sagemaker_studio_lifecycle_config.jupyterlab_autoshutdown[0].arn
        }
      }
    }
  }

  default_user_settings {
    execution_role      = var.role_arn != null ? var.role_arn : aws_iam_role.default[0].arn
    security_groups     = var.security_groups
    studio_web_portal   = "ENABLED"
    default_landing_uri = "studio::"

    dynamic "code_editor_app_settings" {
      for_each = var.code_editor_app_settings == null ? { create : true } : {}

      content {
        lifecycle_config_arns = [aws_sagemaker_studio_lifecycle_config.codeeditor_autoshutdown[0].arn]

        default_resource_spec {
          instance_type        = "ml.t3.medium"
          lifecycle_config_arn = aws_sagemaker_studio_lifecycle_config.codeeditor_autoshutdown[0].arn
        }
      }
    }

    dynamic "jupyter_lab_app_settings" {
      for_each = var.jupyter_lab_app_settings == null ? { create : true } : {}
      content {
        lifecycle_config_arns = [aws_sagemaker_studio_lifecycle_config.jupyterlab_autoshutdown[0].arn]

        default_resource_spec {
          instance_type        = "ml.t3.medium"
          lifecycle_config_arn = aws_sagemaker_studio_lifecycle_config.jupyterlab_autoshutdown[0].arn
        }
      }
    }
  }

  retention_policy {
    home_efs_file_system = var.retention_policy.home_efs_file_system
  }
}

resource "aws_sagemaker_user_profile" "default" {
  for_each = var.auth_mode == "IAM" ? { for user in var.user_profiles : user => true } : {}

  region            = var.region
  domain_id         = aws_sagemaker_domain.default.id
  user_profile_name = each.key
  tags              = var.tags

  user_settings {
    execution_role  = var.role_arn != null ? var.role_arn : aws_iam_role.default[0].arn
    security_groups = var.security_groups
  }
}
