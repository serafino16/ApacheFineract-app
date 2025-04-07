provider "aws" {
  alias  = "prod"
  region = "eu-west-1"
}

provider "aws" {
  alias  = "prodbackup"
  region = "eu-west-2"
}
provider "aws" {
  alias  = "devstage"
  region = "eu-west-3"
}

resource "aws_lb" "nlb_devstage" {
  provider           = aws.devstage
  name               = "devstage-nlb"
  internal           = false
  load_balancer_type = "network"
  security_groups    = [aws_security_group.allow_all.id]
  subnets            = ["subnet-xyz-devstage"]

  enable_deletion_protection = false
}


resource "aws_lb" "nlb_prod" {
  provider           = aws.prod
  name               = "prod-nlb"
  internal           = false
  load_balancer_type = "network"
  security_groups    = [aws_security_group.allow_all.id]
  subnets            = ["subnet-xyz-prod"]

  enable_deletion_protection = false
}


resource "aws_lb" "nlb_prodbackup" {
  provider           = aws.prodbackup
  name               = "prodbackup-nlb"
  internal           = false
  load_balancer_type = "network"
  security_groups    = [aws_security_group.allow_all.id]
  subnets            = ["subnet-xyz-prodbackup"]

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "loan_management_data_backend_devstage" {
  provider = aws.devstage
  name     = "loan-management-backend-tg"
  port     = 8080
  protocol = "TCP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id

  health_check {
    protocol = "TCP"
    port     = 8080
    interval = 30
    timeout  = 5
    unhealthy_threshold = 2
    healthy_threshold   = 2
  }
}


resource "aws_lb_target_group" "loan_data_management_backend_prod" {
  provider = aws.prod
  name     = "loan-management-backend-tg"
  port     = 8080
  protocol = "TCP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id

  health_check {
    protocol = "TCP"
    port     = 8080
    interval = 30
    timeout  = 5
    unhealthy_threshold = 2
    healthy_threshold   = 2
  }
}


resource "aws_lb_target_group" "loan_data_management_backend_prodbackup" {
  provider = aws.prodbackup
  name     = "loan-management-backend-tg"
  port     = 8080
  protocol = "TCP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id

  health_check {
    protocol = "TCP"
    port     = 8080
    interval = 30
    timeout  = 5
    unhealthy_threshold = 2
    healthy_threshold   = 2
  }
}


resource "aws_lb_listener" "nlb_listener_devstage" {
  provider           = aws.devstage
  load_balancer_arn = aws_lb.nlb_devstage.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.loan_management_backend_devstage.arn
  }
}


resource "aws_lb_listener" "nlb_listener_prod" {
  provider           = aws.prod
  load_balancer_arn = aws_lb.nlb_prod.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.loan_management_backend_prod.arn
  }
}


resource "aws_lb_listener" "nlb_listener_prodbackup" {
  provider           = aws.prodbackup
  load_balancer_arn = aws_lb.nlb_prodbackup.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.loan_management_backend_prodbackup.arn
  }
}
resource "aws_security_group" "backend_sg" {
  name        = "backend-sg"
  description = "Security group for Backend NLB"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "backend-sg"
  }
}
