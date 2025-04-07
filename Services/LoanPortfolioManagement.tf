resource "kubernetes_service_account" "fineract_portfolio_managemnt" {
  depends_on = [ aws_iam_role_policy_attachment.irsa_iam_role_policy_attach ]
  metadata {
    name      = "fineract-portfolio"
    namespace = "apache-fineract"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.irsa_iam_role.arn
      }
  }
}

resource "kubernetes_deployment" "fineract_portfolio_managemnt {
  metadata {
    name      = "fineract-portfolio"
    namespace = "apache-fineract"
    labels = {
      app = "fineract-portfolio"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "fineract-portfolio"
      }
    }

    template {
      metadata {
        labels = {
          app = "fineract-portfolio"
        }
      }

      spec {
        service_account_name = kubernetes_service_account.spree_admin.metadata[0].name

        container {
          name  = "fineract-portfolio"
          image = "123456789112.dkr.ecr.us-east-1.amazonaws.com/ruby:3.1.0-alpine"

          ports {
            container_port = 4000
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
resource "kubernetes_service" "fineract_portfolio_managemnt" {
  metadata {
    name      = "fineract-portfolio"
    namespace = "apache-fineract"
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type" = "internal"
      "service.beta.kubernetes.io/aws-load-balancer-scheme" = "internal"
    }
  }

  spec {
    selector = {
      app = "fineract-portfolio"
    }

    type = "LoadBalancer"

    port {
      protocol    = "TCP"
      port        = 443
      target_port = 443
    }
  }
}
resource "kubernetes_horizontal_pod_autoscaler" "fineract_hpa" {
  metadata {
    name      = "fineract-hpa"
    namespace = "apache-fineract"
  }

  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "HorizontalPodAutoscaler"
      name        = "fineract-portfolio"
    }

    min_replicas = 1
    max_replicas = 10

    target_cpu_utilization_percentage = 80
  }
}

