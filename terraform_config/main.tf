# Key pair for Ansible
resource "aws_key_pair" "tester_key" {
  key_name   = "tester-key"
  public_key = file("~/.ssh/appKey.pub")
}

# Security group for EC2 instances
resource "aws_security_group" "tester_sg" {
  name        = "tester-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "${var.app_name}-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ipv4_rule" {
  security_group_id = aws_security_group.tester_sg.id
  
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "ssh_rule" {
  security_group_id = aws_security_group.tester_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "all_all_outbound_traffic" {
    security_group_id = aws_security_group.tester_sg.id
    cidr_ipv4         = "0.0.0.0/0"
    ip_protocol       = "-1"
}

# EC2 instances
resource "aws_instance" "tester_instance" {
    for_each = {
        for inst in local.instances : inst.name => inst.env
    }

    ami                    = data.aws_ami.ubuntu.id
    instance_type          = "t2.micro"
    key_name               = aws_key_pair.tester_key.key_name
    vpc_security_group_ids = [aws_security_group.tester_sg.id]

    tags = {
      Name        = each.key
      Environment = each.value
    }   
}