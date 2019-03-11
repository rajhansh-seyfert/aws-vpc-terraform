# Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  key_name = "id_rsa"
  public_key = "${file("${var.key_path}")}"
}




# Define webserver inside the public subnet
resource "aws_instance" "wb" {
   ami  = "${var.ami}"
   instance_type = "t2.micro"
   key_name = "${aws_key_pair.default.id}"
   subnet_id = "${aws_subnet.private-subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.sgweb.id}"]
   source_dest_check = false
   user_data = "${file("userdata.sh")}"

  tags {
    Name = "webserver"
  }
}
