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

# optional for calling db details
output "db_instance_endpoint" {
  value = aws_db_instance.wordpress_db.endpoint
}

output "db_instance_id" {
  value = aws_db_instance.wordpress_db.id
}

output "db_endpoint" {
  value = aws_db_instance.wordpress_db.endpoint
}

output "wordpress_public_ip" {
  value = aws_instance.wordpress.public_ip
}

#trying to get rid of ids
# Needed to wire modules together automatically
output "vpc_id" {
  value = aws_vpc.DeployLab_VPC.id
}

output "subnet_ids" {
  value = [for subnet in aws_subnet.public : subnet.id]
}

output "db_subnet_ids" {
  value = [for subnet in aws_subnet.private : subnet.id]
}
