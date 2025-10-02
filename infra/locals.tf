locals {
  name   = "FullStackApp"
  region = "ap-south-1"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Environment = "Test"
    Repository = "https://github.com/Karthik-Sakthivel-Git/crayondata-fullstack-app-assignment.git"
  }
}