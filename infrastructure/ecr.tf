resource "aws_ecr_repository" "colorgateway" {
  name = "${var.colorgateway_image_name}"
}

resource "aws_ecr_repository" "colorteller" {
  name = "${var.colorteller_image_name}"
}
