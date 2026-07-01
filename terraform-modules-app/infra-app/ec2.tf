# key pair login

resource "aws_key_pair" "terra_key" {
  key_name   = "${var.env}-terraform-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINGO77v8uvW4+u1S7Lme95B3ctYaV4wKdmSjDgi3zDM3 kajal@Kajal"
  tags = {
    Environment = var.env
  }
}
resource "aws_default_vpc" "ayush" {

}
 
resource "aws_security_group" "my_security_group" {
  name        = "${var.env}-automata"
  description = "this will add a tf generated security group"
  vpc_id      = aws_default_vpc.ayush.id #interpolation

  # inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSh open"


  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "http open"
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "all access open outbound"
  }
  tags = {
    Name = "${var.env}-automate"
  }


}
# ec2 instance
resource "aws_instance" "my-instances" {
    count = var.instance_count
   # meta argument
  depends_on = [ aws_security_group.my_security_group, aws_key_pair.terra_key ]
  

  key_name        = aws_key_pair.terra_key.key_name
  security_groups = [aws_security_group.my_security_group.name]
  instance_type   = var.instance_type
  ami             = var.ami_type
  root_block_device {
    volume_size = var.env == "prd" ? 20 : 10
    volume_type = "gp3"
  }
  tags = {
    Name = "${var.env}-automate"
    Environment = var.env
    }
}

 