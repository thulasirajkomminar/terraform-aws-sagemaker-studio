# terraform-aws-sagemaker-studio

Terraform module to create and manage a SageMaker AI studio

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| aws | >= 3.10 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.10 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | The name for the sagemaker resources | `string` | n/a | yes |
| subnet\_ids | The subnet ids | `list(string)` | n/a | yes |
| tags | A mapping of tags to assign to the resources | `map(string)` | n/a | yes |
| vpc\_id | The VPC id | `string` | n/a | yes |
| app\_network\_access\_type | Specifies the VPC used for non-EFS traffic | `string` | `"PublicInternetOnly"` | no |
| lcc\_python\_kernel | Specifies the custom lifecycle config file | `string` | `null` | no |
| role\_arn | The arn of the IAM role to use for sagemaker | `string` | `null` | no |
| security\_groups | The security groups | `list(string)` | `null` | no |
| user\_profiles | The subnet ids | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| domain | The attributes of the sagemaker domain |
| user\_profile | The attributes of the users of sagemaker domain |

<!--- END_TF_DOCS --->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_efs_backup_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_backup_policy) | resource |
| [aws_iam_role.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_sagemaker_domain.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_domain) | resource |
| [aws_sagemaker_user_profile.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_user_profile) | resource |
| [aws_iam_policy_document.assume_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name for the sagemaker resources | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | The subnet ids | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resources | `map(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC id | `string` | n/a | yes |
| <a name="input_app_network_access_type"></a> [app\_network\_access\_type](#input\_app\_network\_access\_type) | Specifies the VPC used for non-EFS traffic | `string` | `"VpcOnly"` | no |
| <a name="input_app_security_group_management"></a> [app\_security\_group\_management](#input\_app\_security\_group\_management) | The entity that creates and manages the required security groups for inter-app communication in VPCOnly mode | `string` | `"Service"` | no |
| <a name="input_auth_mode"></a> [auth\_mode](#input\_auth\_mode) | The mode of authentication that members use to access the domain | `string` | `"IAM"` | no |
| <a name="input_default_space_jupyter_lab_app_settings"></a> [default\_space\_jupyter\_lab\_app\_settings](#input\_default\_space\_jupyter\_lab\_app\_settings) | The default settings for the JupyterLab application for the spaces | `any` | `null` | no |
| <a name="input_default_space_kernel_gateway_app_settings"></a> [default\_space\_kernel\_gateway\_app\_settings](#input\_default\_space\_kernel\_gateway\_app\_settings) | The default settings for the Kernel Gateway application for the spaces | `any` | `null` | no |
| <a name="input_default_user_code_editor_app_settings"></a> [default\_user\_code\_editor\_app\_settings](#input\_default\_user\_code\_editor\_app\_settings) | The default Code Editor application settings for the users | `any` | `null` | no |
| <a name="input_default_user_jupyter_lab_app_settings"></a> [default\_user\_jupyter\_lab\_app\_settings](#input\_default\_user\_jupyter\_lab\_app\_settings) | The default settings for the JupyterLab application for the users | `any` | `null` | no |
| <a name="input_default_user_kernel_gateway_app_settings"></a> [default\_user\_kernel\_gateway\_app\_settings](#input\_default\_user\_kernel\_gateway\_app\_settings) | The default settings for the Kernel Gateway application for the users | `any` | `null` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The kms key id of the AWS KMS Customer Managed Key to be used to encrypt the EFS volume attached to the domain | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | The Region where this resource will be managed. Defaults to the Region set in the provider configuration | `string` | `null` | no |
| <a name="input_retention_policy"></a> [retention\_policy](#input\_retention\_policy) | The retention policy for this domain, which specifies whether resources will be retained after the Domain is deleted | <pre>object({<br/>    home_efs_file_system = optional(string, "Retain")<br/>  })</pre> | `{}` | no |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | The arn of the IAM role to use for sagemaker | `string` | `null` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | The security groups | `list(string)` | `null` | no |
| <a name="input_tag_propagation"></a> [tag\_propagation](#input\_tag\_propagation) | Indicates whether custom tag propagation is supported for the domain | `string` | `"DISABLED"` | no |
| <a name="input_user_profiles"></a> [user\_profiles](#input\_user\_profiles) | The sagemaker user profiles | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain"></a> [domain](#output\_domain) | The attributes of the sagemaker domain |
| <a name="output_user_profile"></a> [user\_profile](#output\_user\_profile) | The attributes of the users of the sagemaker domain |
<!-- END_TF_DOCS -->
