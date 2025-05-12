resource "aws_launch_configuration" "wordpress_launch_config" {
  name          = "wordpress-launch-config"
  image_id      = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.webserver_sg.id]
  iam_instance_profile = aws_iam_instance_profile.student_ec2_instance_profile.name

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "wordpress_asg" {
  desired_capacity     = 2
  min_size             = 1
  max_size             = 3
  vpc_zone_identifier  = var.subnet_ids
  launch_configuration = aws_launch_configuration.wordpress_launch_config.id
  health_check_type    = "EC2"
  wait_for_capacity_timeout = "0"

  tag {
    key                 = "Name"
    value               = "WordPress Auto Scaling"
    propagate_at_launch = true
  }
}

