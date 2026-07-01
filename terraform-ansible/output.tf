output "ec2_public_ip" {
    value = [
       for key in aws_instance.my-instances : key.public_ip
    ]
  
}