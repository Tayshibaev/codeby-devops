variable "ami_id" {
  description = "ID of the AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "Type of instance to launch"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Name tag for the instance"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet where to launch the instance"
  type        = string
}