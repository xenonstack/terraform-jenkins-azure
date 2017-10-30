## Terraform azure scripts for jenkins

 Setup you private Azure creds before running the script :

```
subscription_id 	= "---"
client_id 		    = "---"
client_secret 	  = "---"
tenant_id 		    = "---"
```

##### Steps to initialize this project
- Enter all the variables in variable file (terraform.tfvars)
- Add storage account , container name , Access Key at the end of  azure_vm.tf file for storing terraform state file remotely to azure (you need to have a already created storage account for storing the state file )

Run following commands to run & test Terraform scripts :

- terraform init          (To initialize the project)
- terraform plan        (To check the changes to be made by Terraform on azure )
- terraform apply       (To apply the changes to azure)


To verify Jenkins , open the public ip Azure VM in browser
```azure_vm_public_ip:8080```    
& get Jenkins Admin password by SSHing the VM

- The Backend state file will be stored on your azure storage container.
- This file can be used for next module .
