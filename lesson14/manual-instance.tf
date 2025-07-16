resource "aws_instance" "manual-instance" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.public.id
  vpc_security_group_ids = [data.aws_security_group.public.id]
  tags = {
    Name = "manual-instance"
  }
}