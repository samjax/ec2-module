provider "aws" {
  region = var.region
}

data "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
}

resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [data.aws_security_group.allow_ssh.id]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${path.module}/terraform.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = ["ip a"]
  }

  tags = {
    Name = "SimpleEC2"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_module"
  description = "Allow SSH"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Change this for more security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
