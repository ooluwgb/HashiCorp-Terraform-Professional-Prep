#######################################################################################
# OUTPUT VALUES
#######################################################################################
# Exposes the IDs of key resources created by the infrastructure module.
# These outputs can be used by other Terraform configurations or for reference.

output "launch_template_id" {
  description = "The ID of the launch template."
  value       = module.infrastructure.launch_template_id
}

output "autoscaling_group_id" {
  description = "The ID of the Auto Scaling group."
  value       = module.infrastructure.autoscaling_group_id
}
