### TASK

Use Terraform to create an AWS EC2 instance with the following specifications:
- Instance Type: `t3.nano`
- Install Nginx on the instance
- Display "Hello Devops!" on the Nginx default page

### PREREQUISITES

- Install [Terraform](https://www.terraform.io/downloads.html) on your machine.
- Install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) and configure it with your AWS credentials.

### SOLUTION

1. **Provider Configuration**  
   The `main.tf` file defines the AWS provider and sets the region and instance type using variables.

2. **Security Group**  
   A security group is created to allow all inbound and outbound traffic.  
   *Note: Allowing all traffic is not recommended for production environments. This is done here for simplicity.*

3. **EC2 Instance**  
   An EC2 instance is created with the specified type.  
   The `user_data` script installs Nginx and sets "Hello Devops!" as the default page.

4. **File Location**  
   All Terraform configuration is in `main.tf`.

### USAGE

1. Open a terminal and navigate to the directory containing `main.tf`.
2. Run the following commands:

   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

3. When prompted, type `yes` to confirm and apply the changes.

After deployment, you can access the public IP of your EC2 instance in a browser. The Nginx default page will