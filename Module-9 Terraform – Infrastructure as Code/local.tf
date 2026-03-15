resource "local_file" "my_file" {
  content  = "This is a file created by Terraform."
  filename = "my_file.txt"
}