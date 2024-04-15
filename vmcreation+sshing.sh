#!/bin/bash

#updating packages
apt update

#Installing lolcat
apt install lolcat 

#Installing Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
echo "installing Terraform" | lolcat
sudo apt update && sudo apt install terraform -y

#terraform installed do the init plan and apply 
echo "applying Terraform init" | lolcat
terraform init
echo "applying Terraform plan" | lolcat
terraform plan
echo "applying Terraform apply" | lolcat
terraform apply -auto-approve

#get details of the resource created
echo "listing terraform resources" | lolcat
terraform state list 
ip_address=$(terraform state show azurerm_linux_virtual_machine.my_vm[0] | grep -w "public_ip_address" | awk '{print$3}'| tr -d '"')
uname=$(terraform state show azurerm_linux_virtual_machine.my_vm[0] | grep -w "admin_username" | awk '{print$3}'| tr -d '"')

sshpass -p $PASS ssh -o StrictHostKeyChecking=no $uname@$ip_address

exit

terraform destroy -y