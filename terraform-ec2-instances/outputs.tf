# output for count
# output "ec2_public_ip" {
#     value = aws_instance.my-instances[*].public_ip
# }
# output "ec2_public_dns" {
#     value = aws_instance.my-instances[*].public_dns # single output
# }
# output "ec2_private_dns" {
#     value = aws_instance.my-instances[*].private_ip
# }

# output for for each
output "ec2_public_ip" {
    value = [
       for key in aws_instance.my-instances : key.public_ip
    ]
  
}
output "ec2_public_dns" {
    value = [
       for key in aws_instance.my-instances : key.public_dns
    ]
  
}
output "ec2_private_dns" {
    value = [
       for key in aws_instance.my-instances : key.private_dns
    ]
  
}