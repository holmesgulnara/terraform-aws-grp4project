variable region {
  type = string
  description = "Provide region"
}

variable vpc_name {
    type = string
    description = "Provide vpc name"
}

variable vpc_cidr {
  type = string
  description = "Provide vpc cidr block"
}

variable subnet1_cidr {
  type = string
  description = "Provide subnet1 cidr block"
}

variable subnet2_cidr {
  type = string
  description = "Provide subnet2 cidr block"
}

variable subnet3_cidr {
  type = string
  description = "Provide subnet3 cidr block"
}

variable subnet1_name {
  type = string
  description = "Provide subnet1 name"
}

variable subnet2_name {
  type = string
  description = "Provide subnet2 name"
}

variable subnet3_name {
  type = string
  description = "Provide subnet3 name"
}

variable ip_on_launch {
    type = bool  
}

variable "ports" {
  description = "Provide list of  ports"
  type = list(object({
    from_port = number
    to_port   = number
  }))
}

variable "enable_blue_env" {
  description = "Enable blue environment"
  type        = bool
  default     = true
}

variable "blue_instance_count" {
  description = "Number of Instances in blue environment"
  type        = number
  default     = 2  
}

variable "enable_green_env" {
  description = "Enable blue environment"
  type        = bool
  default     = false
}

variable "green_instance_count" {
  description = "Number of Instances in blue environment"
  type        = number
  default     = 2  
}


variable key_name {
  type = string
  description = "Provide key name"
}

variable load_balancer_name {
    type = string
    description = "Provide LB name"
}

variable load_balancer_type {
  type = string
  description = "Provide LB type"
}

variable lb_listener_port {
    type = number
    description = "Provide LB listener port"
}

variable lb_listener_protocol {
    type = string
    description = "Provide LB listener Protocol"
}

data "aws_ami" "amazon" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20240329.0-x86_64-gp2"]
  }

  owners = ["137112412989"] # Canonical
}

variable lb_tg_ports {
  type = list
  description = "Provide LB TG ports"
}

variable lb_tg_protocol {
  type = list
  description = "Provide LB TG protocol"
}

variable instance_type {
    type = string
    description = "Provide Instance type"
}

variable IGW_name {
  type = string
  description = "Provide IGW name"
}

variable rt_name {
  type = string
  description = "Provide RT name"
}

variable blue_instance_name {
  type = string
  description = "Provide blue instance name"
}

variable blue_lb_tg {
  type = string
  description = "Provide LB TG name for blue instance"
}

variable sg_name {
  type = string
  description = "Provide SG name"
}

variable sg_protocol {
  type = string
  description = "Provide SG protocol"
}

variable "traffic_distribution" {
  description = "Level of traffic distribution"
  type = string
}

variable green_instance_name {
  type = string
  description = "Provide green instance name"
}

variable green_lb_tg {
  type = string
  description = "Provide LB TG name for green onstance"
}

locals {
traffic_dist_map = {
  blue = {
    blue = 100
    green = 0
  }
  blue-90 = {
    blue = 90
    green = 10
  }
  split = {
    blue = 50
    green = 50
  }
   green = {
    blue = 0
    green = 100
  }
  green-90 = {
    blue = 10
    green = 90
  }
  split = {
    blue = 50
    green = 50
  }
}
}

