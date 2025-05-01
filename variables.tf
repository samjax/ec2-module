variable "region" {
  default = "us-east-1"
}

variable "ami_id" {
  description = "The AMI to use"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "terraform.pem"
}
