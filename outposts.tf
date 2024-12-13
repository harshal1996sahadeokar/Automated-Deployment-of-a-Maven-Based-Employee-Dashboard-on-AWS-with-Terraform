output "instance_public_ip" {
  value = aws_instance.tomcat.public_ip
  description = "Public IP of the Tomcat server"
}
