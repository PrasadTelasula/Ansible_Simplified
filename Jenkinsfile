pipeline {
    agent any
    tools {terraform "Terraform01221"}

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/PrasadTelasula/Ansible.git'
            }
            
        }
        
        stage('Generate-SSH-Keys') {
            steps {
                sh 'mkdir keys'
                sh 'ssh-keygen -t rsa -m PEM -f keys/acsLaunchKey -q -N ""'
                sh 'ssh-keygen -t rsa -m PEM -f keys/centosLaunchKey -q -N ""'
                sh 'ssh-keygen -t rsa -m PEM -f keys/ubuntuLaunchKey -q -N ""'
                sh 'ssh-keygen -t rsa -m PEM -f keys/windowsLaunchKey -q -N ""'
                
            }
        }
        
        stage('Terraform-Version-Check') {
            steps {
                sh 'terraform --version'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
        
        stage('Deploy approval') {
            steps {
                input 'Destroy Inftrastructure ?'
                // Destroy resources 
                sh 'terraform destroy --auto-approve'
                // Remove Keys
                sh 'rm -rf keys'
                // Remove state Files
                sh 'rm -rf terraform.tfstate*'
            }   
        }
    }
}
