pipeline {
    agent any
        environment {
        AWS_ACCESS_KEY_ID = credentials('jenkins-aws') // Utilise l'ID du credential
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws') // L'ID de credential est utilisé pour les deux clés
        SSH_KEY               = '/home/jenkins/.ssh/mariam-key.pem'   // Chemin de la clé SSH privée
    }

    stages {
        stage('Clone repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Mariamyammoun/DevOps-Project.git'
            }
        }
        stage('Run Terraform and Ansible') {
            steps {
                script {
                    sh '''
                    #!/bin/bash
                    set -xe
                    
                    cd Terraform
                    sed -i "s/server_name/${SERVER_NAME}/g" backend.tf
                    export TF_VAR_name=${SERVER_NAME}
                    
                    terraform init
                    terraform plan
                    terraform $TERRAFORM_ACTION -auto-approve
                    
                    if [ "$TERRAFORM_ACTION" = "destroy" ]; then
                        exit 0
                    else
                        cd ../Ansible
                        ansible-playbook -i /opt/ansible/inventory/aws_ec2.yaml apache.yaml
                    fi
                    '''
                }
            }
        }
    }
}
