module "dev-infra" {
    source = "./infra-app"
    env = "dev"
    bucket_name = "terra-su"
    instance_count = 1
    instance_type= "t3.micro"
    ami_type = "ami-02167eae61967e403"
    hash_key="studentID"

  
}
module "prd-infra" {
    source = "./infra-app"
    env = "prd"
    bucket_name = "terra-su"
    instance_count = 1
    instance_type= "t3.micro"
    ami_type = "ami-02167eae61967e403"
    hash_key="studentID"

  
}