# key pair login

resource "aws_key_pair" "terra_key" {
  key_name   = "${var.env}-terraform-key-ansible"
  public_key = file("tera-key-ansible.pub")
  tags = {
    Environment = var.env
  }
}
resource "aws_default_vpc" "ayush" {

}
 
resource "aws_security_group" "my_security_group" {
  name        = "${var.env}-automate-sg"
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
  tags = {
    Name = "${var.env}-automate-sg"
    Environment = var.env
    }


}
# ec2 instance
resource "aws_instance" "my-instances" {
  for_each = tomap({
    "Ayush-automate-master" = "ami-02167eae61967e403" # ubuntu
    "Ayush-automate-1" = "ami-02167eae61967e403" # ubuntu
    "Ayush-automate-2" ="ami-0da467f007dfebd6b" #red-hat
    "Ayush-automate-3"="ami-0cb473a1f3c06c13d" #amazon linux
  }) # meta argument
  depends_on = [ aws_security_group.my_security_group, aws_key_pair.terra_key ]
  

  key_name        = aws_key_pair.terra_key.key_name
  security_groups = [aws_security_group.my_security_group.name]
  instance_type   = "t3.micro"
  ami             = each.value

  root_block_device {
    volume_size = 10
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
 