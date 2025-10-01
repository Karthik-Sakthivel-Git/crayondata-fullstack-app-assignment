module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.4.0"
  
  name = "FullStackApp-VPC"
  cidr = local.vpc_cidr

  azs                 = local.azs
  private_subnets     = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  public_subnets      = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]

  private_subnet_names = ["Private-subnet-01", "Private-subnet-02", "Private-subnet-03"]

  create_database_subnet_group  = false
  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false

  enable_dns_hostnames = true
  enable_dns_support   = true

#   enable_dhcp_options              = true
#   dhcp_options_domain_name         = "service.consul"
#   dhcp_options_domain_name_servers = ["127.0.0.1", "10.10.0.2"]

  tags = local.tags

}