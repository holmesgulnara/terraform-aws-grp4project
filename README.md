# terraform-aws-grp4project

# terraform-aws-group4
##  Create main.tf and input following:
```hcl
module "vpc" {
    source = "holmesgulnara/grp4project/aws"
    version = "0.0.1"
    region = "us-east-2"
    vpc_cidr = "10.0.0.0/16"
    subnet1_cidr = "10.0.1.0/24"
    subnet2_cidr = "10.0.2.0/24"
    subnet3_cidr = "10.0.3.0/24"
    ip_on_launch = true
    instance_type = "t2.micro"
    subnet1_name = "grp4-subnet1"
    subnet2_name = "grp4-subnet2"
    subnet3_name = "grp4-subnet3"
    key_name = "bastion-key"
    load_balancer_name = "grp4-app-lb"
    load_balancer_type = "application"
    lb_listener_port = 80
    lb_listener_protocol = "HTTP"
    lb_tg_ports = [80]
    lb_tg_protocol = ["HTTP"]
    IGW_name = "grp4-IGW"
    rt_name = "grp4-rt"
    blue_instance_name = "blue-instance"
    blue_lb_tg = "blue-tg-lb"
    sg_name = "group-4"
    sg_protocol = "tcp"
    green_instance_name = "green-instance"
    green_lb_tg = "green-tg-lb"

ports = [
  { from_port = 22, to_port = 22 },
  { from_port = 80, to_port = 80 },
  { from_port = 443, to_port = 443 }               
]

traffic_distribution = "split"
enable_green_env = true
}
```

## Prerequisites to be created locally to run this code:
### 1. Create blue.sh file for blue instance and input following:
```hcl
#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo '<!DOCTYPE html>
<html>
<head>
    <title>Welcome</title>
    <style>
        body { background-color: #0000FF; } /* Sets background to blue */
        h1 { color: white; text-align: center; }
        p { color: white; text-align: center; }
    </style>
</head>
<body>
    <h1>Welcome to the Blue Server!</h1>
    <p>This is a blue-themed page served from $(hostname -f).</p>
</body>
</html>' | sudo tee /var/www/html/index.html > /dev/null
```
### 2. Create green.sh for green instance and input following:
```hcl
#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo '<!DOCTYPE html>
<html>
<head>
    <title>Welcome</title>
    <style>
        body { background-color: #00FF00; } /* Sets background to green */
        h1 { color: white; text-align: center; }
        p { color: white; text-align: center; }
    </style>
</head>
<body>
    <h1>Welcome to the Green Server!</h1>
    <p>This is a green-themed page served from $(hostname -f).</p>
</body>
</html>' | sudo tee /var/www/html/index.html > /dev/null
```
### 3. Create manually S3 bucket with the name "group4-kaizen" and enable versioning. Create backend.tf file with following content:
```hcl
terraform {
  backend "s3" {
    bucket = "group4-kaizen"
    key    = "path/terraform.tfstate"
    region = "us-east-2"
  }
}
```