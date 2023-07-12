variable "key_pair" {
  description = "The key pair name for the EC2 instance"
  type        = string
}
variable "ami" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "security_group_id" {
  description = "The security group ID for the EC2 instance"
  type        = string
}

variable "domain" {
  description = "The domain for the Nginx server"
  type        = string
}

variable "embeddings_host" {
  description = "The host for the embeddings endpoint"
  type        = string
}

variable "chat_completions_host" {
  description = "The host for the chat completions endpoint"
  type        = string
}

variable "audio_transcriptions_host" {
  description = "The host for the audio transcriptions endpoint"
  type        = string
}

variable "audio_translations_host" {
  description = "The host for the audio translations endpoint"
  type        = string
}

variable "moderations_host" {
  description = "The host for the moderations endpoint"
  type        = string
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = "t2.micro"
  vpc_security_group_ids = [var.security_group_id]
  key_name      = var.key_pair

  user_data = <<-EOF
    #!/bin/bash
    set -e
    if [ ! -f /etc/letsencrypt/live/${var.domain}/fullchain.pem ]; then
      sudo apt update
      sudo apt install -y nginx software-properties-common
      sudo add-apt-repository ppa:certbot/certbot
      sudo apt install -y python-certbot-nginx
      sudo certbot --nginx -d ${var.domain} -d www.${var.domain}
    fi
    echo "server {
      listen 80;
      listen 443 ssl;
      server_name ${var.domain} www.${var.domain};
      ssl_certificate /etc/letsencrypt/live/${var.domain}/fullchain.pem;
      ssl_certificate_key /etc/letsencrypt/live/${var.domain}/privkey.pem;
      location /v1/embeddings {
        proxy_pass https://${var.embeddings_host};
      }
      location /v1/chat/completions {
        proxy_pass https://${var.chat_completions_host};
      }
      location /v1/audio/transcriptions {
        proxy_pass https://${var.audio_transcriptions_host};
      }
      location /v1/audio/translations {
        proxy_pass https://${var.audio_translations_host};
      }
      location /v1/moderations {
        proxy_pass https://${var.moderations_host};
      }
    }" | sudo tee /etc/nginx/sites-available/default
    sudo systemctl restart nginx
  EOF

  tags = {
    Name = "example-instance-tag"
  }
}
