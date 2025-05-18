variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
  default     = ""  # empty default meaning 'not set'
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
  # default can be added if needed, but probably better to provide when calling module
}

# Database variables
variable "db_username" {
  description = "Master username for RDS"
  type        = string
}

variable "db_password" {
  description = "Master password for RDS"
  type        = string
  sensitive   = true
}

variable "db_instance_identifier" {
  description = "The RDS instance identifier"
  type        = string
  default     = "wordpress-db-instance"
}

variable "db_subnet_ids" {
  description = "List of private subnet IDs for RDS subnet group"
  type        = list(string)
}

variable "database_sg_id" {
  description = "Security Group ID for the database"
  type        = string
}

variable "web_sg_id" {
  description = "Security group ID for web servers"
  type        = string
}
