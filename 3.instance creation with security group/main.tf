provider "aws" {
   region = "ap-southeast-2"
}

resource "aws_key_pair" "key-name" {
   key_name = "test-ssh"
   public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "aws_security_group" "sgdb2"{
  name = "sg_test_web-2"
  description = "Allow traffic from public subnet"
 
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  }


resource "aws_instance" "test-vm" {
   ami = "ami-00e17d1165b9dd3ec"
   instance_type = "t2.micro"
   key_name = "test-ssh"
   vpc_security_group_ids  = ["${aws_security_group.sgdb2.id}"]

   tags {
     Name = "test-vm"
   }
}



