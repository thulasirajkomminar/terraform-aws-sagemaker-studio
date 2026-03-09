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

    dynamic "jupyter_lab_app_settings" {
      for_each = var.default_space_jupyter_lab_app_settings != null ? { create : var.default_space_jupyter_lab_app_settings } : {}

      content {
        lifecycle_config_arns = lookup(jupyter_lab_app_settings.value, "lifecycle_config_arns", null)

        app_lifecycle_management {
          idle_settings {
            idle_timeout_in_minutes     = lookup(jupyter_lab_app_settings.value.app_lifecycle_management.idle_settings, "idle_timeout_in_minutes", null)
            lifecycle_management        = lookup(jupyter_lab_app_settings.value.app_lifecycle_management.idle_settings, "lifecycle_management", null)
            max_idle_timeout_in_minutes = lookup(jupyter_lab_app_settings.value.app_lifecycle_management.idle_settings, "max_idle_timeout_in_minutes", null)
            min_idle_timeout_in_minutes = lookup(jupyter_lab_app_settings.value.app_lifecycle_management.idle_settings, "min_idle_timeout_in_minutes", null)
          }
        }

        default_resource_spec {
          instance_type = lookup(jupyter_lab_app_settings.value.default_resource_spec, "instance_type", null)
        }
      }
    }

    dynamic "kernel_gateway_app_settings" {
      for_each = var.default_space_kernel_gateway_app_settings != null ? { create : var.default_space_kernel_gateway_app_settings } : {}

      content {
        custom_image {
          app_image_config_name = lookup(kernel_gateway_app_settings.value.custom_image, "app_image_config_name", null)
          image_name            = lookup(kernel_gateway_app_settings.value.custom_image, "image_name", null)
          image_version_number  = lookup(kernel_gateway_app_settings.value.custom_image, "image_version_number", null)
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
      for_each = var.default_user_code_editor_app_settings != null ? { create : var.default_user_code_editor_app_settings } : {}

      content {
        lifecycle_config_arns = lookup(code_editor_app_settings.value, "lifecycle_config_arns", null)

        app_lifecycle_management {
          idle_settings {
            idle_timeout_in_minutes     = lookup(code_editor_app_settings.value.app_lifecycle_management.idle_settings, "idle_timeout_in_minutes", null)
            lifecycle_management        = lookup(code_editor_app_settings.value.app_lifecycle_management.idle_settings, "lifecycle_management", null)
            max_idle_timeout_in_minutes = lookup(code_editor_app_settings.value.app_lifecycle_management.idle_settings, "max_idle_timeout_in_minutes", null)
            min_idle_timeout_in_minutes = lookup(code_editor_app_settings.value.app_lifecycle_management.idle_settings, "min_idle_timeout_in_minutes", null)
          }
        }

        default_resource_spec {
          instance_type        = lookup(code_editor_app_settings.value.default_resource_spec, "instance_type", null)
          lifecycle_config_arn = lookup(code_editor_app_settings.value.default_resource_spec, "lifecycle_config_arn", null)
        }
      }
    }

    dynamic "jupyter_lab_app_settings" {
      for_each = var.default_user_jupyter_lab_app_settings != null ? { create : var.default_user_jupyter_lab_app_settings } : {}

      content {
        lifecycle_config_arns = lookup(jupyter_lab_app_settings.value, "lifecycle_config_arns", null)

        app_lifecycle_management {
          idle_settings {
            idle_timeout_in_minutes     = lookup(jupyter_lab_app_settings.value.app_lifecycle_management.idle_settings, "idle_timeout_in_minutes", null)
            lifecycle_management        = lookup(jupyter_lab_app_settings.value.app_lifecycle_management.idle_settings, "lifecycle_management", null)
            max_idle_timeout_in_minutes = lookup(jupyter_lab_app_settings.value.app_lifecycle_management.idle_settings, "max_idle_timeout_in_minutes", null)
            min_idle_timeout_in_minutes = lookup(jupyter_lab_app_settings.value.app_lifecycle_management.idle_settings, "min_idle_timeout_in_minutes", null)
          }
        }

        default_resource_spec {
          instance_type        = lookup(jupyter_lab_app_settings.value.default_resource_spec, "instance_type", null)
          lifecycle_config_arn = lookup(jupyter_lab_app_settings.value.default_resource_spec, "lifecycle_config_arn", null)
        }
      }
    }

    dynamic "kernel_gateway_app_settings" {
      for_each = var.default_user_kernel_gateway_app_settings != null ? { create : var.default_user_kernel_gateway_app_settings } : {}

      content {
        custom_image {
          app_image_config_name = lookup(kernel_gateway_app_settings.value.custom_image, "app_image_config_name", null)
          image_name            = lookup(kernel_gateway_app_settings.value.custom_image, "image_name", null)
          image_version_number  = lookup(kernel_gateway_app_settings.value.custom_image, "image_version_number", null)
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
