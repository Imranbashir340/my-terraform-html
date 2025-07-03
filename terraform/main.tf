provider "aws" {
  region = "us-east-1"
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}

resource "aws_instance" "web" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y git httpd
              systemctl start httpd
              systemctl enable httpd
              cd /var/www/html
              git clone https://github.com/${var.GITHUB_USERNAME}/html-auto-deploy.git site
              cp site/index.html index.html
            EOF

  tags = {
    Name = "GitHubAutoWeb"
  }
}
