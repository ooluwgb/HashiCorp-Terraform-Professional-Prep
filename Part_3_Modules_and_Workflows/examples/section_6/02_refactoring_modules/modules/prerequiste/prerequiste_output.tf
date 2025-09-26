###############################################################################
# OUTPUTS
###############################################################################
output "ghost_txt_file" {
  value = local.ghost_txt
}

output "aws_cli_creds_file" {
  value = local.credsfile
}

output "aws_cli_conf_file" {
  value = local.conffile
}

output "eu_north_role_arn" {
  value = aws_iam_role.eu_north_role.arn
}

output "ghost_access_key" {
  value = aws_iam_access_key.ghost.id
}

output "ghost_secret_key" {
  value = aws_iam_access_key.ghost.secret
}