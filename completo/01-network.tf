/*
 VPC: https://www.terraform.io/docs/providers/aws/r/vpc.html
*/
resource "aws_vpc" "principal" {
  // Esto dejará reservadas 256 IPs
  cidr_block = "10.0.0.0/24"

  // Los tags son opcionales, los ponemos para para sean faciles de categorizar.
  tags = {
    Name = "principal"
  }
}

/*
  Subnet: https://www.terraform.io/docs/providers/aws/r/subnet.html
*/

resource "aws_subnet" "publica-1" {
  // Lo enlazamos a la VPC
  // Referenciamos el ID de los resources con el formato (resource).(nombre_que_le_pusiste).(propiedad) sin comillas
  vpc_id     = aws_vpc.principal.id
  // Del 10.0.0.0 al 10.0.0.127
  cidr_block = "10.0.0.0/25"

  // Los tags son opcionales, los ponemos para para sean faciles de categorizar.
  tags = {
    Name = "publica-1"
  }
}
