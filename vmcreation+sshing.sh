!/bin/bash

#updating packages
apt update


#Installing Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform -y

#terraform installed do the init plan and apply 
terraform init
terraform plan
terraform apply -auto-approve

#get details of the resource created
terraform state list 
ip_address=$(terraform state show azurerm_linux_virtual_machine.my_vm[0] | grep -w "public_ip_address" | awk '{print$3}')
uname=$(terraform state show azurerm_linux_virtual_machine.my_vm[0] | grep -w "admin_username" | awk '{print$3}')

ssh $uname@$ip_address

exit

terraform destroy -y