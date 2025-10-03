variable "app_network_access_type" {
  type        = string
  default     = "VpcOnly"
  description = "Specifies the VPC used for non-EFS traffic"

  validation {
    condition     = contains(["PublicInternetOnly", "VpcOnly"], var.app_network_access_type)
    error_message = "Valid values are `PublicInternetOnly` and `VpcOnly`"
  }
}

variable "app_security_group_management" {
  type        = string
  default     = "Service"
  description = "The entity that creates and manages the required security groups for inter-app communication in VPCOnly mode"

  validation {
    condition     = contains(["Service", "Customer"], var.app_security_group_management)
    error_message = "Valid values are `Service` and `Customer`"
  }
}

variable "auth_mode" {
  type        = string
  default     = "IAM"
  description = "The mode of authentication that members use to access the domain"

  validation {
    condition     = contains(["IAM", "SSO"], var.auth_mode)
    error_message = "Valid values are `IAM` and `SSO`"
  }
}

variable "code_editor_app_settings" {
  type        = any
  default     = null
  description = "The Code Editor application settings"
}

variable "jupyter_lab_app_settings" {
  type        = any
  default     = null
  description = "The settings for the JupyterLab application"
}

variable "jupyter_server_app_settings" {
  type        = any
  default     = null
  description = "The Jupyter server's app settings"
}

variable "kms_key_id" {
  type        = string
  default     = null
  description = "The kms key id of the AWS KMS Customer Managed Key to be used to encrypt the EFS volume attached to the domain"
}

variable "region" {
  type        = string
  default     = null
  description = "The Region where this resource will be managed. Defaults to the Region set in the provider configuration"
}

variable "retention_policy" {
  type = object({
    home_efs_file_system = optional(string, "Retain")
  })
  default     = {}
  description = "The retention policy for this domain, which specifies whether resources will be retained after the Domain is deleted"

  validation {
    condition     = contains(["Retain", "Delete"], var.retention_policy.home_efs_file_system)
    error_message = "Valid values are `Retain` or `Delete`"
  }
}

variable "name" {
  type        = string
  description = "The name for the sagemaker resources"
}

variable "role_arn" {
  type        = string
  default     = null
  description = "The arn of the IAM role to use for sagemaker"
}

variable "security_groups" {
  type        = list(string)
  default     = null
  description = "The security groups"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resources"
}

variable "tag_propagation" {
  type        = string
  default     = "DISABLED"
  description = "Indicates whether custom tag propagation is supported for the domain"

  validation {
    condition     = contains(["ENABLED", "DISABLED"], var.tag_propagation)
    error_message = "Valid values are: `ENABLED` and `DISABLED`"
  }
}

variable "subnet_ids" {
  type        = list(string)
  description = "The subnet ids"
}

variable "user_profiles" {
  type        = list(string)
  default     = []
  description = "The sagemaker user profiles"
}

variable "vpc_id" {
  type        = string
  description = "The VPC id"
}
