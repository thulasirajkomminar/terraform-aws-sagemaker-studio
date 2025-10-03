resource "aws_sagemaker_studio_lifecycle_config" "jupyterlab_autoshutdown" {
  count = var.jupyter_lab_app_settings == null || var.jupyter_server_app_settings == null ? 1 : 0

  region                           = var.region
  studio_lifecycle_config_name     = "lcc-jupyterlab-autoshutdown"
  studio_lifecycle_config_app_type = "JupyterLab"
  studio_lifecycle_config_content  = filebase64("${path.module}/scripts/lcc_jupyterlab_autoshutdown.sh")
  tags                             = var.tags
}

resource "aws_sagemaker_studio_lifecycle_config" "codeeditor_autoshutdown" {
  count = var.code_editor_app_settings == null ? 1 : 0

  region                           = var.region
  studio_lifecycle_config_name     = "lcc-codeeditor-autoshutdown"
  studio_lifecycle_config_app_type = "CodeEditor"
  studio_lifecycle_config_content  = filebase64("${path.module}/scripts/lcc_codeeditor_autoshutdown.sh")
  tags                             = var.tags
}
