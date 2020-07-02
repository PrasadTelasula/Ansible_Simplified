# Ansible servers provisioning with Terraform

![Alt text](https://github.com/PrasadTelasula/Ansible/blob/master/arch_diag/arch_diag.png?raw=true "Architecture")

# pre-requisites 

````
apt update
apt install awscli

wget https://releases.hashicorp.com/terraform/0.12.28/terraform_0.12.28_linux_amd64.zip
unzip terraform_0.12.28_linux_amd64.zip
mv terraform /usr/local/bin/
````

````
bash startup.sh
````

# Create Infrastructure
````
terraform init
````
````
terraform plan
````
````
terraform apply --auto-approve
````

# Destroy Infrastructure
````
terraform destroy --auto--aprove
````

# Cleanup 
````
bash cleanup.sh
````
