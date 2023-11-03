provider "aws" {
}


resource "aws_instance" "jenkins-host" {
  ami                     = "ami-053b0d53c279acc90"
  instance_type           = "t2.micro"
  subnet_id               = var.subnet_id
  key_name                = var.key_name

  vpc_security_group_ids = [var.vpc_security_group_ids]

  associate_public_ip_address = true

  user_data = file("jenkins-controller-install.sh")

  tags = {
    Name = "jenkins-host-d7"
  }
}

resource "aws_instance" "jenkins-node1" {
  ami                     = "ami-053b0d53c279acc90"
  instance_type           = "t2.micro"
  subnet_id               = var.subnet_id
  key_name                = var.key_name

  vpc_security_group_ids = [var.vpc_security_group_ids]

  associate_public_ip_address = true

  user_data = file("jenkins-node1-install.sh")

  tags = {
    Name = "jenkins-build-test-node-d7"
  }
}

resource "aws_instance" "jenkins-node2" {
  ami                     = "ami-053b0d53c279acc90"
  instance_type           = "t2.micro"
  subnet_id               = var.subnet_id
  key_name                = var.key_name

  vpc_security_group_ids = [var.vpc_security_group_ids]

  associate_public_ip_address = true

  user_data = file("jenkins-node2-install.sh")

  tags = {
    Name = "jenkins-deploy-node-d7"
  }
}