variable "image_id" {
  type = string
  description = "The id of AMI to use for EC2"
}
variable "instance_type" {
  type = string
  description = "The type of instance to use"
  default = "t3.micro"
}