#######################################################
###### OUTPUTS
#######################################################

output "launch_template_id" {
  description = "The ID of the launch template"
  value       = aws_launch_template.this.id
}

output "autoscaling_group_id" {
  description = "The ID of the autoscaling group"
  value       = aws_autoscaling_group.this.id
}
