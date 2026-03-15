resource "aws_s3_bucket" "omkar_bucket" {
  bucket = "omkar-terraform-bucket-2821"
}
resource "aws_instance" "my_ec2" {
  ami           = "ami-0a14f53a6fe4dfcd1"
  instance_type = "t3.micro"
  key_name      = "cloud-batch-key"

  tags = {
    Name = "terraform-ec2"
  }
}