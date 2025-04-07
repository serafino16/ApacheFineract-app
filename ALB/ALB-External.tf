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

resource "aws_lb" "alb_devstage" {
  provider           = aws.devstage
  name               = "devstage-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_all.id]
  subnets            = ["subnet-xyz-devstage"]

  enable_deletion_protection = false
}


resource "aws_lb" "alb_prod" {
  provider           = aws.prod
  name               = "prod-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_all.id]
  subnets            = ["subnet-xyz-prod"]

  enable_deletion_protection = false
}


resource "aws_lb" "alb_prodbackup" {
  provider           = aws.prodbackup
  name               = "prodbackup-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_all.id]
  subnets            = ["subnet-xyz-prodbackup"]

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "loan_management_backend_devstage" {
  provider = aws.devstage
  name     = "loan-management-backend-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id

  health_check {
    protocol = "HTTP"
    port     = 8080
    interval = 30
    timeout  = 5
    unhealthy_threshold = 2
    healthy_threshold   = 2
  }
}


resource "aws_lb_target_group" "loan_management_backend_prod" {
  provider = aws.prod
  name     = "loan-management-backend-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id

  health_check {
    protocol = "HTTP"
    port     = 8080
    interval = 30
    timeout  = 5
    unhealthy_threshold = 2
    healthy_threshold   = 2
  }
}


resource "aws_lb_target_group" "loan_management_backend_prodbackup" {
  provider = aws.prodbackup
  name     = "loan-management-backend-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id

  health_check {
    protocol = "HTTP"
    port     = 8080
    interval = 30
    timeout  = 5
    unhealthy_threshold = 2
    healthy_threshold   = 2
  }
}

resource "aws_lb_target_group" "client_management_frontend_devstage" {
  provider = aws.devstage
  name     = "client-management-frontend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id

  health_check {
    protocol = "HTTP"
    port     = 80
    interval = 30
    timeout  = 5
    unhealthy_threshold = 2
    healthy_threshold   = 2
  }
}


resource "aws_lb_target_group" "client_management_frontend_prod" {
  provider = aws.prod
  name     = "client-management-frontend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id

  health_check {
    protocol = "HTTP"
    port     = 80
    interval = 30
    timeout  = 5
    unhealthy_threshold = 2
    healthy_threshold   = 2
  }
}

resource "aws_lb_target_group" "client_management_frontend_prodbackup" {
  provider = aws.prodbackup
  name     = "client-management-frontend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id

  health_check {
    protocol = "HTTP"
    port     = 80
    interval = 30
    timeout  = 5
    unhealthy_threshold = 2
    healthy_threshold   = 2
  }
}



resource "aws_lb_listener" "alb_listener_prod" {
  provider           = aws.prod
  load_balancer_arn = aws_lb.alb_prod.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.loan_management_backend_prod.arn
  }
}

resource "aws_lb_listener" "alb_listener_prodbackup" {
  provider           = aws.prodbackup
  load_balancer_arn = aws_lb.alb_prodbackup.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.loan_management_backend_prodbackup.arn
  }
}

resource "aws_lb_listener" "alb_listener_devstage" {
  provider           = aws.devstage
  load_balancer_arn = aws_lb.alb_devstage.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.loan_management_backend_devstage.arn
  }
}




