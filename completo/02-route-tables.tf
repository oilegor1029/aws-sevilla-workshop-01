/*
  Internet Gateway: https://www.terraform.io/docs/providers/aws/r/internet_gateway.html
*/

resource "aws_internet_gateway" "igw" {
  // Lo creamos en la VPC
  // Referenciamos el ID de los resources con el formato (resource).(nombre_que_le_pusiste).(propiedad) sin comillas
  vpc_id = aws_vpc.principal.id

  // Los tags son opcionales, los ponemos para para sean faciles de categorizar.
  tags = {
    Name = "igw"
  }
}

/*
  Route Table: https://www.terraform.io/docs/providers/aws/r/route_table.html
*/

resource "aws_route_table" "publica" {
  // La creamos en la VPC
  // Referenciamos el ID de los resources con el formato (resource).(nombre_que_le_pusiste).(propiedad) sin comillas
  vpc_id = aws_vpc.principal.id

  route {
    //Que lo que entre sea de donde sea, entre por IGW
    cidr_block = "0.0.0.0/0"
    //Lo enlazamos al Gateway
    // Referenciamos el ID de los resources con el formato (resource).(nombre_que_le_pusiste).(propiedad) sin comillas
    gateway_id = aws_internet_gateway.igw.id
  }

  // Los tags son opcionales, los ponemos para para sean faciles de categorizar.
  tags = {
    Name = "publica"
  }
}

/*
  Route Table Associations: https://www.terraform.io/docs/providers/aws/r/route_table_association.html
*/

resource "aws_route_table_association" "igw-a" {
  //Asociamos RouteTable con Subnet
  // Referenciamos el ID de los resources con el formato (resource).(nombre_que_le_pusiste).(propiedad) sin comillas
  subnet_id      = aws_subnet.publica-1.id
  route_table_id = aws_route_table.publica.id
}
