resource "aws_instance" "wordpress_us_east_1a" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  #iam_instance_profile   = aws_iam_instance_profile.student_ec2_instance_profile.name
  associate_public_ip_address = false
  tags = {
    Name = "WordPress Instance 1"
  }

  ebs_block_device {
    device_name = "/dev/sdh"
    volume_size = 10  # Size in GB
    volume_type = "gp2"
    delete_on_termination = true
  }
}


resource "aws_instance" "bastion_host" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_ids[1]
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  #iam_instance_profile   = aws_iam_instance_profile.student_ec2_instance_profile.name
  associate_public_ip_address = true
  tags = {
    Name = "Bastion Host"
  }

  ebs_block_device {
    device_name = "/dev/sdh"
    volume_size = 10  # Size in GB
    volume_type = "gp2"
    delete_on_termination = true
  }
}

resource "aws_instance" "wordpress_us_east_1b" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_ids[2]
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  #iam_instance_profile   = aws_iam_instance_profile.student_ec2_instance_profile.name
  associate_public_ip_address = false
  tags = {
    Name = "WordPress Instance 2"
  }

  ebs_block_device {
    device_name = "/dev/sdh"
    volume_size = 10  # Size in GB
    volume_type = "gp2"
    delete_on_termination = true
  }
}
