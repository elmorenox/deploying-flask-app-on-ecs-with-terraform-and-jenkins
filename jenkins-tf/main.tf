provider "aws" {
}


resource "aws_instance" "jenkins-host-or-node1" {
  count                  = 2
  ami                     = "ami-053b0d53c279acc90"
  instance_type           = "t2.micro"
  subnet_id               = var.subnet_id
  key_name                = var.key_name

  vpc_security_group_ids = [var.vpc_security_group_ids]

  associate_public_ip_address = true

  user_data = (count.index == 0 ? 
    templatefile("jenkins-controller-or-node1-install.sh", { argument = "" }) : 
    templatefile("jenkins-controller-or-node1-install.sh", { argument = "node" })

  )

  tags = {
    Name = count.index == 0 ? "jenkins-host-d7" : "container-instance-d7"
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
    Name = "d7-jenkins-node"
  }
}


output "instance_ip" {
    value = [aws_instance.jenkins-host.public_ip, aws_instance.jenkins-node.public_ip]

}