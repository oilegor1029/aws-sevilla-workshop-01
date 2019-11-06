/*
  Internet Gateway: https://www.terraform.io/docs/providers/aws/r/internet_gateway.html
*/

resource "aws_internet_gateway" "" {
  // Recuerda enlazarlo con la VPC
  // Referenciamos el ID de los resources con el formato (resource).(nombre_que_le_pusiste).(propiedad) sin comillas
  vpc_id = ""

  // Los tags son opcionales, los ponemos para para sean faciles de categorizar.
  tags = {
    Name = ""
  }
}

/*
  Route Table: https://www.terraform.io/docs/providers/aws/r/route_table.html
*/

resource "aws_route_table" "" {
  // Recuerda enlazarla con la VPC
  // Referenciamos el ID de los resources con el formato (resource).(nombre_que_le_pusiste).(propiedad) sin comillas
  vpc_id = ""

  route {
    //Que lo que entre sea de donde sea, entre por IGW
    cidr_block = "0.0.0.0/0"
    //Recuerda enlazarlo al internet_gateway
    // Referenciamos el ID de los resources con el formato (resource).(nombre_que_le_pusiste).(propiedad) sin comillas
    gateway_id = ""
  }

  // Los tags son opcionales, los ponemos para para sean faciles de categorizar.
  tags = {
    Name = ""
  }
}

/*
  Route Table Associations: https://www.terraform.io/docs/providers/aws/r/route_table_association.html
*/

resource "aws_route_table_association" "" {
  // Recuerda enlazarla con la subnet
  // Recuerda enlazarla con la route_table
  // Referenciamos el ID de los resources con el formato (resource).(nombre_que_le_pusiste).(propiedad) sin comillas
  subnet_id      = ""
  route_table_id = ""
}
