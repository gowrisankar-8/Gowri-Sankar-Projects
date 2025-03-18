provider "aws" {
   region = "ap-southeast-2"
}

resource "aws_key_pair" "key-name" {
   key_name = "test-ssh"
   public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "aws_instance" "test-vm" {
   ami = "ami-00e17d1165b9dd3ec"
   instance_type = "t2.micro"
   key_name = "test-ssh"

   tags {
     Name = "test-vm"
   }
}