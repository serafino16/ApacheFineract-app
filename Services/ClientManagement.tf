resource "kubernetes_service_account" "fineract-client-managemnt" {
  depends_on = [ aws_iam_role_policy_attachment.irsa_iam_role_policy_attach ]
  metadata {
    name      = "fineract-client-managemnt"
    namespace = "apache-fineract"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.irsa_iam_role.arn
      }
  }
}

resource "kubernetes_deployment" "fineract-client-managemnt" {
  metadata {
    name      = "fineract-client-managemnt"
    namespace = "apache-fineract"
    labels = {
      app = "fineract-client-managemnt"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "fineract-client-managemnt"
      }
    }

    template {
      metadata {
        labels = {
          app = "fineract-client-managemnt"
        }
      }

      spec {
        service_account_name = kubernetes_service_account.spree_core.metadata[0].name

        container {
          name  = "fineract-client-managemnt"
          image = "123456789612.dkr.ecr.us-east-1.amazonaws.com/ruby:3.1.0-alpine"

          ports {
            container_port = 3000
          }
          
          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "256Mi"
            }
          }

          env {
            name  = "DATABASE_URL"
            value = "postgres://admin:password@postgres:5432/spree"
          }

          env {
            name  = "REDIS_URL"
            value = "127456789012.dkr.ecr.us-east-1.amazonaws.com/spree-commerce"
          }

          
          liveness_probe {
            http_get {
              path = "/healthz"
              port = 3000
            }
            initial_delay_seconds = 10
            period_seconds        = 5
          }

          
          readiness_probe {
            http_get {
              path = "/readyz"
              port = 3000
            }
            initial_delay_seconds = 5
            period_seconds        = 5
          }
        } 
          volume_mount {
            name       = "efs-storage"
            mount_path = "/app/storage"
          }
        }

        
        volume {
          name = "efs-storage"

          persistent_volume_claim {
            claim_name = "efs-pvc"
          }
      }
    }
  }
}
resource "kubernetes_service" "spree_api" {
  metadata {
    name      = "fineract-client-managemnt"
    namespace = "apache-fineract"
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type"                = "external"
      "service.beta.kubernetes.io/aws-load-balancer-scheme"              = "internet-facing"
      "service.beta.kubernetes.io/aws-load-balancer-target-group-attributes" = "stickiness.enabled=true,stickiness.lb_cookie.duration_seconds=600"
      "external-dns.alpha.kubernetes.io/hostname" = "www.spree-commerce.com"
    }
  }

  spec {
    selector = {
      app = "fineract-client-managemnt"
    }

    type = "LoadBalancer"

    port {
      protocol    = "TCP"
      port        = 80
      target_port = 3000
    }
  }
}
