resource "aws_sagemaker_studio_lifecycle_config" "jupyterlab_autoshutdown" {
  studio_lifecycle_config_name     = "lcc-jupyterlab-autoshutdown"
  studio_lifecycle_config_app_type = "JupyterServer"
  studio_lifecycle_config_content  = filebase64("${path.module}/scripts/lcc_jupyterlab_autoshutdown.sh")
  tags                             = var.tags
}

resource "aws_sagemaker_studio_lifecycle_config" "codeeditor_autoshutdown" {
  studio_lifecycle_config_name     = "lcc-codeeditor-autoshutdown"
  studio_lifecycle_config_app_type = "CodeEditor"
  studio_lifecycle_config_content  = filebase64("${path.module}/scripts/lcc_ce_autoshutdown_v2.sh")
  tags                             = var.tags
}
