variable "image_id" {
  type = string
  description = "The id of AMI to use for EC2"
}
variable "instance_type" {
  type = string
  description = "The type of instance to use"
  default = "t3.micro"
}

variable "region" {
  type = string
  default = "ap-southeast-1"
}

variable "amis" {
  type = map(string)
  default = {
    "ap-southeast-1" = "ami-01dc51e87421923b6"
    "us-west-1" = "ami-01dc51e87421923b6"
  }
}