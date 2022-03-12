module "EC2_Instance" {
    source = "github.com/terraform-aws-modules/terraform-aws-ec2-instance.git"

 name = "I1"
 ami =  "ami-0454207e5367abf01"
 instance_type = "t2.micro"
subnet_id = "PublicTrainingsubnet2"
tags = {
    terraform = "true"
    Environment = "PROD"

}
}