before running the script, please make sure you have the following installed:
-AWS CLI for powershell
-terraform
-kubectl

please change directory (cd) to the location you placed the files before running the following command!

******************************************
RUN THIS IN WINDOWS POWERSHELL WITH ADMIN:
******************************************

powershell.exe -executionpolicy bypass -file exercisescript.ps1


---------------------------------------------------------------------
The Process:
---------------------------------------------------------------------
-this will first creat/run terraform, usually 10-11 minutes maximum.
-The script will then update the context via AWS CLI
-create a namespace for health-check using kubectl
-create secret credentials
-deploy the application
-display the services in progress/the deployment and its ip range.

*Once the script stops you must wait about 60-90 seconds for the load balancer to become available

-Copy the external IP shown and add ':8000' to the end of it in a broswer
-The json text should display!




-------------------------------------------
Cleanup:
-------------------------------------------
- in the AWS console under EC2 > Load balancers, delete the load balancer
- While still in the directory in powershell, type the following: 

terraform destroy -auto-approve

*this process can take up to 10-11 minutes
- In the AWS console, go to the VPC directory and delate the vpc titled "main"
- You should be good to go!