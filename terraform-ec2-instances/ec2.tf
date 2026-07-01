# key pair login

resource "aws_key_pair" "terra_key" {
  key_name   = "terraform-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINGO77v8uvW4+u1S7Lme95B3ctYaV4wKdmSjDgi3zDM3 kajal@Kajal"
}
resource "aws_default_vpc" "ayush" {

}
 
resource "aws_security_group" "my_security_group" {
  name        = "automata"
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
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Flask app"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "all access open outbound"
  }


}
# ec2 instance
resource "aws_instance" "my-instances" {
  for_each = tomap({
    "Ayush-automate-micro" = "t3.micro"
    "Ayush-automate-medium" = "t3.micro"
  }) # meta argument
  depends_on = [ aws_security_group.my_security_group, aws_key_pair.terra_key ]
  

  key_name        = aws_key_pair.terra_key.key_name
  security_groups = [aws_security_group.my_security_group.name]
  instance_type   = each.value
  ami             = var.ec2_ami_id
  user_data       = file("install_nginx.sh")
  root_block_device {
    volume_size = var.env == "prd" ? 20 : var.ec2_default_root_storage_size
    volume_type = "gp3"
  }
  tags = {
    Name = each.key
    Environment = var.env
    }
}
# import karne ke liye
# resource "aws_instance" "my_new_instances" {
#   ami  = "unknown"
#   instance_type = "unknown"

  
# }
 