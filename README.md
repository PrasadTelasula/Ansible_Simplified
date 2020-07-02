# Ansible servers provisioning with Terraform

![Alt text](https://github.com/PrasadTelasula/Ansible/blob/master/arch_diag/arch_diag.png?raw=true "Architecture")

# Clone this repository

````
git clone https://github.com/PrasadTelasula/Ansible_Terraform_AWS_CICD.git
````


# Generate SSH Keys.

````
mkdir -p keys
````
````
cd keys
````


| Node Name | Command                    |
| ------------- | ------------------------------ |
| `ACS`      | ssh-keygen -t rsa -m PEM -f keys/acsLaunchKey -q -N ""      |
| `CentosNode`   | ssh-keygen -t rsa -m PEM -f keys/centosLaunchKey -q -N ""     |
| `UbuntNode`   | ssh-keygen -t rsa -m PEM -f keys/ubuntuLaunchKey -q -N ""     |
| `WindowsNode`   | ssh-keygen -t rsa -m PEM -f keys/windowsLaunchKey -q -N ""    |


# CICD 
````
1. Create S3 Buckets
````
   | `Command` |
   | :---------: |
   | `aws s3api create-bucket --bucket terraform-cicd-artifacts --region ap-south-1` |
   | `aws s3api create-bucket --bucket terraform-cicd-state-file --region ap-south-1` |
   | `aws s3api create-bucket --bucket terraform-cicd-state-file --region ap-south-1` |


````
2. Create DynamoDB Table to store the Terraform state lock.
````
   | `Table Name` | `Prmary Key` |
   | ------------ | ----------- |
   | `terraform-cicd-state` | `LockID` |

````
3. Create IAM role with full admin privileges. (for codebuild)
````
   | `Role Name ` |
   | ------------ |
   | `terraform-cicd-role` |

````
4. Create CodeCommit & push the code
````
   | `Repository Name `|
   | ----------------- |
   | `terraform-cicd` |
````
5. Create CodeBuild Projects.
````
   | `Project Name` |  `IAM Role` | `Environment Variables` | `Logs to S3`  | `Path Prefix` |
   | :-------------- | :----------- | :----------------------- | :------------- | :------------- |
   | `terraform-cicd-deploy` | `terraform-cicd-role` | `TERRAFORM_VERSION=0.12.28` | `terraform-cicd-artifacts` | `deployLogs` |
   | `terraform-cicd-destroy` | `terraform-cicd-role` | `TERRAFORM_VERSION=0.12.28` | `terraform-cicd-artifacts` | `destroyLogs` |

````
6. Create pipeline
   Source Code Checkout -> Change Approval (Manual) -> CodeBuild (Deploy) -> Destroy Approval (Manual) -> CodeBuild (Destroy)
````
   | `Pipeline Name ` |
   | ---------------- |
   | `tomcat-cicd` |
