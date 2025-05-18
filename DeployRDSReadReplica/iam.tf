# resource "aws_iam_role" "student_ec2_instance_role" {
#   name               = "studentEC2InstanceRole"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action    = "sts:AssumeRole"
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#         Effect    = "Allow"
#         Sid       = ""
#       }
#     ]
#   })
# }

# resource "aws_iam_instance_profile" "student_ec2_instance_profile" {
#   name = "studentEC2InstanceProfile"
#   role = aws_iam_role.student_ec2_instance_role.name
# }


# i would like to add polocies and roles where the login information is instead of here
# i think that would be easier then attempting to seperate them

# a couple things were commented out in the ec2 and autoscaling file because of this change
