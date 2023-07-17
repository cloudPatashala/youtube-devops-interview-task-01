data "aws_ami" "cp_b00_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.1.20230705.0-kernel-6.1-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Canonical
}

resource "aws_instance" "web" {
  ami                  = data.aws_ami.cp_b00_ami.id
  instance_type        = "t3.micro"
  key_name             = "cp-b00"
  subnet_id            = "subnet-093f81b2dfe931798"
  security_groups      = ["${aws_security_group.cp_b00_ssh_allow.id}"]
  iam_instance_profile = aws_iam_instance_profile.cp_b00_instance_profile.name

  tags = {
    Name = "cp-b00-ec2-linux"
  }
}
