deploy an AWS RDS Multi-AZ and Read Replica AWS
https://app.pluralsight.com/hands-on/labs/aacf9e92-0bb7-4969-aaf7-e2e106a7e339?ilx=true

what will need to be added off of first glance includes:
#   vpc                                                 

#   subnets both private and public                     
        will need three for both so 6 in total
        take another peak at what you have already to see if you need .local

#   route tables                                        
        three in total
        one public conneted to the top layer of pricate and public
        one private connect to the two bottom layers of private and public
        another one that isn't assigned to a subnet

#   internet gateway                                    
        connected to the public route table
        intertwined from the start when add subnets to route tables

#   elastic ip                                          
        assigned one when you added in the NAT gateway

#   NAT gateway                                         
        connected to the private table
        ended up need to be intertwined from the start with route tables

#   network acls                                        
        the vpc has a total of 4 NACLs connected to it
        1. default not even associated with anything, so don't worry about this one
                inbound: 100    All traffic     All             All             0.0.0.0/0       Allow
                         *      All traffic     All             All             0.0.0.0/0       Deny

                outbound: same as above

        2. associtated to both public subnets
                        Rule Number Type      Protocol      Port Range           Source       Allow/Deny
                inbound: 100    SSH (22)        TCP (6)         22              0.0.0.0/0       Allow
                         110    HTTP (80)       TCP (6)         80              0.0.0.0/0       Allow
                         120    HTTPS (443)     TCP (6)         443             0.0.0.0/0       Allow
                         130    Custom TCP      TCP (6)         1024 - 65535    0.0.0.0/0       Allow
                         *      All traffic     All             All             0.0.0.0/0       Deny

                outbound: all the same as above

        3. first set of private subnets in 1a and 1b (named applayer in the lab)
                inbound: 100    SSH (22)        TCP (6)         22              10.99.0.0/16    Allow
                         110    HTTP (80)       TCP (6)         80              10.99.0.0/16    Allow
                         120    HTTPS (443)     TCP (6)         443             10.99.0.0/16    Allow
                         130    Custom TCP      TCP (6)         1024 - 65535    0.0.0.0/0       Allow
                         *      All traffic     All             All             0.0.0.0/0       Deny

                outbound: 110    HTTP (80)       TCP (6)         80              0.0.0.0/0       Allow
                          120    HTTPS (443)     TCP (6)         443             0.0.0.0/0       Allow
                          130    Custom TCP      TCP (6)         1024 - 65535    10.99.0.0/16    Allow
                          *      All traffic     All             All             0.0.0.0/0       Deny

        4. second set of private subnets in 1a and 1b (named db layer in lab)
                inbound: 100    MySQL/Aurora(3306)      TCP (6)         3306            10.99.0.0/16    Allow
                         110    Custom TCP              TCP (6)         1024 - 65535    0.0.0.0/0       Allow
                         *      All traffic             All             All             0.0.0.0/0       Deny

                outbound: 100    MySQL/Aurora(3306)     TCP (6)         3306            0.0.0.0/0       Allow   
                         110    Custom TCP              TCP (6)         1024 - 65535    10.99.0.0/16    Allow
                         *      All traffic             All             All             10.99.0.0/16    Deny

# ec2 instances                                         
        there are three instances total, two in east-1a (instance wordpress and bastion host) another one in east 1b (instance wordpress)
        east 1b instance wordpress:
                instance type - t3.micro
                subnet ID - applayer private 2 (your 5)
                vpc id - main vpc
                iam role - studentEC2InstanceRole (i have no iam role as of now)
                connected to an auto scaling group
        east 1a bastion host:
                instance type - t3.micro       
                subnet id - dmz public1 (your 1)
                vpc id - main vpc
                no auto scaling group
                same iam role as above
                is assigned public IPv4s on top fo the private
        east 1a instance wordpress:
                instance type - t3.micro
                subnet id - applayer private 1 (your 2)
                same autoscaling group
                same iam role

#   security groups                                                                                                                
        1. database sg
                 inbound: type - MYSQL/Auruora           protocol - TCP          port range - 3306               source - webseversg
                outbound: IP version - IPv4              type - all traffic      protocol - all                  port range - all               destination - 0.0.0.0/0
        2. webseversg
                 inbound: type - HTTP                    protocol - TCP          port range - 80                 source - loadbalancersg        
                          type - SSH                     protocol - TCP          port range - 22                 source - bastionsg
                outbound: IP version - IPv4              type - all traffic      protocol - all                  port range - all               destination - 0.0.0.0/0
        3. bastionsg
                 inbound: IP version - IPv4              type - SSH              protocol - all                  port range - 22                destination - 0.0.0.0/0
                outbound: IP version - IPv4              type - all traffic      protocol - all                  port range - all               destination - 0.0.0.0/0
        4. loadbalancersg
                 inbound: IP version - IPv4              type - HTTP             protocol - TCP                  port range - 80                destination - 0.0.0.0/0
                          IP version - IPv4              type - HTTPS            protocol - TCP                  port range - 443               destination - 0.0.0.0/0
                outbound: IP version - IPv4              type - all traffic      protocol - all                  port range - all               destination - 0.0.0.0/0
        5. default

# elastic block storage for each instance               

# load balancer                                          
        have yet to add

# auto scailing group                                   

# db                                                    
        probably will need but should double check how it is set up in order to replicate it

# subnet group?  
        don't know if this is required                                                                                 

# amazon eventbridge event buses                        
        don't know if this is required

# route 53 hosted zone                                  
        don't know if this is required

# use the login stuff from git                          
        in turn adjust iam policies
        what are they interacting with and what do they need to do