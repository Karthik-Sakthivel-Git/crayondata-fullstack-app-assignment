# ################################################################################
# # EC2 Instance
# ################################################################################

resource "aws_instance" "my-web-ec2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = module.custom-vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.custom-web-sg.id]
  key_name               = data.aws_key_pair.my-keypair.key_name
  iam_instance_profile   = data.aws_iam_instance_profile.my-instance-profile.name

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 30
    delete_on_termination = true
    encrypted             = true
  }

  tags = merge(local.tags, {
    Name = "${local.name}-EC2"
  })

  associate_public_ip_address = true

  depends_on = [
    module.custom-vpc,
    aws_security_group.custom-web-sg,
    data.aws_iam_instance_profile.my-instance-profile
  ]
}

##Referencing Existing IAM Instance profile##
data "aws_iam_instance_profile" "my-instance-profile" {
  name = "Test-App-Role"
}

##Referencing Existing Key Pair##
data "aws_key_pair" "my-keypair" {
  key_name = "Test-App-KeyPair"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}