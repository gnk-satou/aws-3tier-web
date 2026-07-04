# ---------------------------------------------------------------------------
# Step 1: Web EC2 (Amazon Linux 2023 + nginx, access via SSM only)
# ---------------------------------------------------------------------------

data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "web" {
  ami                    = data.aws_ssm_parameter.al2023.value
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.web.id]
  iam_instance_profile   = aws_iam_instance_profile.web.name

  metadata_options {
    http_tokens = "required" # IMDSv2 enforced
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = 8
    encrypted   = true
  }

  user_data = <<-EOF
    #!/bin/bash
    set -eux
    dnf -y update
    dnf -y install nginx
    cat > /usr/share/nginx/html/index.html <<'HTML'
    <!DOCTYPE html>
    <html lang="ja">
    <head><meta charset="utf-8"><title>aws-3tier-web</title></head>
    <body>
      <h1>aws-3tier-web : Step 1 OK</h1>
      <p>VPC + EC2 (nginx) built with Terraform</p>
    </body>
    </html>
    HTML
    systemctl enable --now nginx
  EOF

  tags = {
    Name = "${local.name_prefix}-web"
  }
}
