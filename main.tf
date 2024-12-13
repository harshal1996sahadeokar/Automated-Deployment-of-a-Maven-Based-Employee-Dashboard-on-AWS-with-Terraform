provider "aws" {
  region = "us-east-1" # Change to your preferred region
}

# Security Group for Tomcat
resource "aws_security_group" "tomcat_sg" {
  name        = "tomcat-sg"
  description = "Allow SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Key Pair
#resource "aws_key_pair" "key" {
  #key_name   = "ANSIBLE"
  #public_key = file("/.ssh/id_ed25519") # Path to your public SSH key
#}

# EC2 Instance
resource "aws_instance" "tomcat" {
  ami           = "ami-005fc0f236362e99f" # Ubuntu 20.04 LTS AMI
  instance_type = "t2.micro"
  #key_name      = aws_key_pair.key.key_name

  vpc_security_group_ids = [aws_security_group.tomcat_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y openjdk-11-jdk tomcat9
    sudo useradd -m -d /opt/tomcat -U -s /bin/false tomcat
    cd /tmp
    wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.0.20/bin/apache-tomcat-10.0.20.tar.gz
    sudo tar xzvf apache-tomcat-10*tar.gz -C /opt/tomcat --strip-components=1
    sudo chown -R tomcat:tomcat /opt/tomcat/
    sudo chmod -R u+x /opt/tomcat/bin
    sudo systemctl start tomcat9
    sudo systemctl enable tomcat9
  EOF

  tags = {
    Name = "TomcatServer"
  }
}
