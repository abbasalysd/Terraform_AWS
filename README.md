# Terraform_AWS
Terraform is a infrastructure as a code which is used to proviioning or setup your infrastructure or resources on cloud.

**Terraform Commands**: terraform init, plan, apply, destroy.

**Terraform init**: terraform init command will download all the packages or dependencies that you mention in the .tf file in provider details and when you give the command 
ls -lart 
You will find the .terraform folder which contains the registry and other files.

**Terraform plan**: This command will not anything but shows you what it is going to do and what are the actions that will take place in the next step
*to add *to change * to destroy

**Terraform Apply**: terraform apply
Will deploy/create your resources that you have given in the .tf file

**Terraform destroy**: terraform destroy
Will delete your resources

**AWS** This repository contains the main.tf file which has the code to create a vpc and subnets, Internet_gateway, Routetable, SG. And an Ec2 instance.

**Terraform installation** file contains the steps to install terraform in Amazon Linux machine.
