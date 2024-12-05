# AWS configurations
variable "aws_region" {
  description = "AWS region where resources will be created"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
}

variable "key_name" {
  description = "Name of the SSH key pair for EC2 access"
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
}

variable "security_group_id" {
  description = "Security group ID for the EC2 instance"
}

# Application configurations
variable "maven_project_url" {
  description = "URL of the Maven project repository (e.g., GitHub or GitLab)"
}

variable "war_file_name" {
  description = "Name of the WAR file to be deployed"
  default     = "employee-dashboard.war"
}

variable "tomcat_version" {
  description = "Version of Tomcat to be installed"
  default     = "9.0.70"
}

# Database configurations
variable "db_username" {
  description = "Database username"
}

variable "db_password" {
  description = "Database password"
}

variable "db_name" {
  description = "Name of the database"
}

variable "db_endpoint" {
  description = "Endpoint of the database"
}

variable "db_port" {
  description = "Port for the database"
  default     = 3306
}

# File locations
variable "source_path" {
  description = "Path to the local Maven project or specific configuration file"
}

variable "destination_path" {
  description = "Path where the file will be placed in the EC2 instance"
  default     = "/var/lib/tomcat/webapps/"
}

# Tags
variable "project_name" {
  description = "Name of the project"
  default     = "Employee Dashboard"
}

variable "environment" {
  description = "Deployment environment (e.g., dev, test, prod)"
  default     = "dev"
}
