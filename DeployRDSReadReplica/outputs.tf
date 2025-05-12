# for the security groups incase i need to reference later
# if used later it would be when i create the resources for said sg's
output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}

output "loadbalancer_sg_id" {
  value = aws_security_group.loadbalancer_sg.id
}

output "webserver_sg_id" {
  value = aws_security_group.webserver_sg.id
}

output "database_sg_id" {
  value = aws_security_group.database_sg.id
}

# more outputs when creating the instances
output "wordpress_instance_1_id" {
  value = aws_instance.wordpress_us_east_1a.id
}

output "wordpress_instance_2_id" {
  value = aws_instance.wordpress_us_east_1b.id
}

output "bastion_host_id" {
  value = aws_instance.bastion_host.id
}
