variable "env" {
    description = "This is the environment"
    type = string
  
}
variable "bucket_name" {
  description = "This is bucket name for my bucker suuu.."
  type = string
}
variable "instance_count" {
    description = "This is count of no of instances"
    type = number
  
}
variable "instance_type" {
    default = "This is type of instances you want to make"
    type = string
  
}
variable "ami_type" {
    description = "This is ami id"
    type = string
  
}
variable "hash_key" {
  description = "This is hash key for dynamodb"
}