# AWS configurations
aws_region        = "us-east-1"
instance_type     = "t2.micro"
ami_id            = "ami-0453ec754f44f9a4a"  # Replace with the appropriate AMI ID
key_name          = "my-key"                # Replace with your SSH key pair name
subnet_id         = "subnet-0123456789abcdef"  # Replace with your subnet ID
security_group_id = "sg-0123456789abcdef"      # Replace with your security group ID

# Application configurations
#maven_project_url = "https://github.com/username/employee-dashboard"  # Replace with your Maven project repository URL
war_file_name     = "employee-dashboard.war"
tomcat_version    = "9.0.70"

# Database configurations
db_username = "admin"
db_password = "mysecurepassword"
db_name     = "employee_dashboard_db"
db_endpoint = "employee-db.xxxxx.us-east-1.rds.amazonaws.com"  # Replace with your RDS endpoint
db_port     = 3306

# File locations
source_path      = "employee-dashboard.war"  # Replace with your local WAR file path
destination_path = "/var/lib/tomcat9/webapps/"             # Path in the EC2 instance

# Tags
project_name = "Employee Dashboard"
environment  = "dev"
