# are you ready? i'm not
# first round of NACLs, connected to both public subnets in east 1a and 1b
resource "aws_network_acl" "public" {
  vpc_id = aws_vpc.DeployLab_VPC.id
  tags = { Name = "public-nacl" }
}



# Inbound Rules
resource "aws_network_acl_rule" "public_inbound_ssh" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "public_inbound_http" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 110
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "public_inbound_https" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 120
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "public_inbound_custom_tcp" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 130
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}



# Outbound Rules (mirror inbound)
resource "aws_network_acl_rule" "public_outbound_ssh" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  egress         = true
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "public_outbound_http" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 110
  egress         = true
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "public_outbound_https" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 120
  egress         = true
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "public_outbound_custom_tcp" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 130
  egress         = true
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}



# Associations to public subnets
resource "aws_network_acl_association" "public-1a"{
  subnet_id      = aws_subnet.public["public-1"].id
  network_acl_id = aws_network_acl.public.id
}

resource "aws_network_acl_association" "public-4b"{
  subnet_id      = aws_subnet.public["public-4"].id
  network_acl_id = aws_network_acl.public.id
}



#################################################################
# second round of NACLs, called app layer to mimic lab
resource "aws_network_acl" "app_layer" {
  vpc_id = aws_vpc.DeployLab_VPC.id
  tags = { Name = "app-layer-nacl" }
}



# Inbound Rules
resource "aws_network_acl_rule" "app_inbound_ssh" {
  network_acl_id = aws_network_acl.app_layer.id
  rule_number    = 100
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "10.99.0.0/16"
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "app_inbound_http" {
  network_acl_id = aws_network_acl.app_layer.id
  rule_number    = 110
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "10.99.0.0/16"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "app_inbound_https" {
  network_acl_id = aws_network_acl.app_layer.id
  rule_number    = 120
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "10.99.0.0/16"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "app_inbound_custom_tcp" {
  network_acl_id = aws_network_acl.app_layer.id
  rule_number    = 130
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}



# Outbound Rules
resource "aws_network_acl_rule" "app_outbound_http" {
  network_acl_id = aws_network_acl.app_layer.id
  rule_number    = 110
  egress         = true
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "app_outbound_https" {
  network_acl_id = aws_network_acl.app_layer.id
  rule_number    = 120
  egress         = true
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "app_outbound_custom_tcp" {
  network_acl_id = aws_network_acl.app_layer.id
  rule_number    = 130
  egress         = true
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "10.99.0.0/16"
  from_port      = 1024
  to_port        = 65535
}



# Associations to app subnets
resource "aws_network_acl_association" "app_1a" {
  subnet_id      = aws_subnet.private["private-2"].id
  network_acl_id = aws_network_acl.app_layer.id
}

resource "aws_network_acl_association" "app_1b" {
  subnet_id      = aws_subnet.private["private-5"].id
  network_acl_id = aws_network_acl.app_layer.id
}



###############################################
# third round of NACLs, called db layer to mimic lab
resource "aws_network_acl" "db_layer" {
  vpc_id = aws_vpc.DeployLab_VPC.id
  tags = { Name = "db-layer-nacl" }
}



# Inbound Rules
resource "aws_network_acl_rule" "db_inbound_mysql" {
  network_acl_id = aws_network_acl.db_layer.id
  rule_number    = 100
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "10.99.0.0/16"
  from_port      = 3306
  to_port        = 3306
}

resource "aws_network_acl_rule" "db_inbound_custom_tcp" {
  network_acl_id = aws_network_acl.db_layer.id
  rule_number    = 110
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}



# Outbound Rules
resource "aws_network_acl_rule" "db_outbound_mysql" {
  network_acl_id = aws_network_acl.db_layer.id
  rule_number    = 100
  egress         = true
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 3306
  to_port        = 3306
}

resource "aws_network_acl_rule" "db_outbound_custom_tcp" {
  network_acl_id = aws_network_acl.db_layer.id
  rule_number    = 110
  egress         = true
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "10.99.0.0/16"
  from_port      = 1024
  to_port        = 65535
}



# Subnet associations
resource "aws_network_acl_association" "db_1a" {
  subnet_id      = aws_subnet.private["private-3"].id
  network_acl_id = aws_network_acl.db_layer.id
}

resource "aws_network_acl_association" "db_1b" {
  subnet_id      = aws_subnet.private["private-6"].id
  network_acl_id = aws_network_acl.db_layer.id
}
