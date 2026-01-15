provider "aws" {
    region = "ap-southeast-1"
}

resource "aws_key_pair" "ec2-aws_key_pair" {
  key_name = "ec2-key-pair"
  public_key = file("./keypair/udemy-key.pub")
}

resource "aws_instance" "iac-demo" {
  ami           = "ami-01dc51e87421923b6"
  instance_type = "t2.micro"
  key_name = aws_key_pair.ec2-aws_key_pair.key_name
  tags = {
    Name = "demo-instance-iac"
  }
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]
}
 
 resource "aws_security_group" "ec2-sg" {
  name        = "ec2-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id = data.aws_vpc.default.id

  ingress = {
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