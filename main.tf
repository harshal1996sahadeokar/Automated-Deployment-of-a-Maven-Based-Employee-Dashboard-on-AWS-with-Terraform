provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "web_sg" {
  name   = "web-sg"

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

resource "aws_security_group" "db_sg" {
  name   = "db-sg"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_db_instance" "employee_db" {
  allocated_storage    = 20
  engine               = "mysql"
  instance_class       = "db.t2.micro"
  db_name              = "HarshalTech"
  username             = "admin"
  password             = var.db_password
  publicly_accessible  = true
  vpc_security_group_ids = [aws_security_group.web_sg.id]
}
resource "aws_instance" "web_server" {
  ami           = "ami-0c02fb55956c7d316" # Ubuntu AMI
  instance_type = "t2.micro"
  key_name      = var.key_name
  security_groups = [aws_security_group.web_sg.name]

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y openjdk-11-jdk tomcat9 maven mysql-client
    sudo systemctl start tomcat9
    sudo systemctl enable tomcat9
  EOF

  provisioner "file" {
    source      = "target/employee-dashboard.war"
    destination = "/tmp/employee-dashboard.war"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/employee-dashboard.war /var/lib/tomcat9/webapps/",
      "sudo systemctl restart tomcat9"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "mysql -h ${aws_db_instance.employee_db.endpoint} -u admin -p${var.db_password} -e \"CREATE TABLE employees (id INT AUTO_INCREMENT PRIMARY KEY, username VARCHAR(50), password VARCHAR(50));\"",
      "mysql -h ${aws_db_instance.employee_db.endpoint} -u admin -p${var.db_password} -e \"INSERT INTO employees (username, password) VALUES ('admin', 'admin123');\""
    ]
  }
}
