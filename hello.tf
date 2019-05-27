resource "aws_instance" "web" {
  ami                         = "ami-0c55b159cbfafe1f0"
  instance_type               = "t2.micro"
  key_name                    = "new"
  vpc_security_group_ids      = ["${aws_security_group.my_sg.id}"]
  subnet_id                   = "${aws_subnet.public.id}"
  associate_public_ip_address = true
  user_data= "${file("file.sh")}"

  tags = {
    Name = "web_app"
  }
  
}
output "ip-address" {
  value = ["${aws_instance.web.*.public_ip}"]
}
