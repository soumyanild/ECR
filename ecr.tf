resource "aws_ecr_repository" "docker-jenkins" {
  name                 = "docker-jenkins"

  image_scanning_configuration {
    scan_on_push = true
  }
}
