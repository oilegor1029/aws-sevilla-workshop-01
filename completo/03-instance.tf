/*
  Security group: https://www.terraform.io/docs/providers/aws/r/security_group.html
*/

resource "aws_security_group" "http-for-web-nginx" {
  name   = "http-for-web-nginx"
  // Lo creamos en la VPC
  // Referenciamos el ID de la VPC usando el recurso [aws_vpc.(nombre_que_le_pusiste).id]
  vpc_id = aws_vpc.principal.id

  //Acceder solo desde el 80 en las IPs marcadas
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  //Que pueda salir a cualquiera
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  // Los tags son opcionales, los ponemos para para sean faciles de categorizar.
  tags = {
    Name = "http-for-web-nginx"
  }
}

/*
  EC2: https://www.terraform.io/docs/providers/aws/r/instance.html
  AMI: https://cloud-images.ubuntu.com/locator/ec2/
*/

resource "aws_instance" "web-nginx" {
  // Amazon Linux AMI 2018.03.0 (HVM) en eu-west-1
  ami           = "ami-0e41581acd7dedd99"
  instance_type = "t2.nano"
  // Lo securizamos con el SG
  vpc_security_group_ids = [
    // Referenciamos el ID de los resources con el formato (resource).(nombre_que_le_pusiste).(propiedad) sin comillas
    aws_security_group.http-for-web-nginx.id
  ]
  // Asociamos IP Pública y que use la subnet
  associate_public_ip_address = true
  // Referenciamos el ID de los resources con el formato (resource).(nombre_que_le_pusiste).(propiedad) sin comillas
  subnet_id                   = aws_subnet.publica-1.id
  // Script de inicio para NGINX
  user_data = <<USER_DATA
#!/bin/bash
sudo apt update -y && sudo apt upgrade -y && sudo apt install nginx -y && sudo systemctl enable nginx && sudo systemctl start nginx
  USER_DATA

  tags = {
    Name = "web-nginx"
  }
}

output "web-ip" {
  // Sacamos la IP de la instancia (propiedad public_ip)
  // Referenciamos el ID de los resources con el formato (resource).(nombre_que_le_pusiste).(propiedad) sin comillas
  value = aws_instance.web-nginx.public_ip
}