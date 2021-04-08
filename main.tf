resource "aws_instance" "myec2" {
  ami           = "ami-09540c9779b451713"
  instance_type = "t2.micro"
  key_name      = "terraform-key"
  tags = {
    "Name" = "labvm1"
  }
  vpc_security_group_ids = [aws_security_group.allow_rdp.id]
  depends_on = [
    aws_security_group.allow_rdp
  ]
}

resource "aws_security_group" "allow_rdp" {
  name = "allow_rdp"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "rdp"
    from_port   = 3389
    protocol    = "tcp"
    to_port     = 3389
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}