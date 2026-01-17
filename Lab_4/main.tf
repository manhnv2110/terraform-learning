#terraform init
#terraform plan
#terraform apply
#terraform destroy
provider "aws" {
    region = var.region
}

resource "aws_key_pair" "ec2-aws_key_pair" {
  key_name = "ec2-key-pair"
  public_key = file("./keypair/udemy-key.pub")
}

resource "aws_instance" "iac-demo" {
  ami           = var.amis[var.region]
  instance_type = var.instance_type
  key_name = aws_key_pair.ec2-aws_key_pair.key_name
  tags = {
    Name = "demo-instance-iac"
  }
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]
}
 
 resource "aws_eip" "demo-eip" {
   instance = aws_instance.iac-demo.id
 }
 resource "aws_security_group" "ec2-sg" {
  name        = "ec2-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  # vpc_id = data.aws_vpc.default.id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "instance_ip_addr_public" {
  value = aws_eip.demo-eip.public_ip
}

output "instance_ip_addr_private" {
  value = aws_instance.iac-demo.private_ip
}

output "sg_id" {
  value = aws_security_group.ec2-sg.id
}