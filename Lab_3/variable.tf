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
  default = ""
}

variable "amis" {
  type = map(string)
  default = {
    "us-east-2" = ""
    "us-west-1" = ""
  }
}