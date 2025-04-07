resource "kubernetes_service_account" "redis" {
  metadata {
    name      = "redis-sa"
    namespace = "apache-fineract"
  }
}

resource "kubernetes_deployment" "redis" {
  metadata {
    name      = "redis"
    namespace = "apache-fineract"
    labels = {
      app = "redis"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "redis"
      }
    }

    template {
      metadata {
        labels = {
          app = "redis"
        }
      }

      spec {
        service_account_name = kubernetes_service_account.redis.metadata[0].name

        container {
          name  = "redis"
          image = "123456786012.dkr.ecr.us-east-1.amazonaws.com/redis:alpine"

          ports {
            container_port = 6379
          }

          liveness_probe {
            exec {
              command = ["redis-cli", "ping"]
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }

          readiness_probe {
            exec {
              command = ["redis-cli", "ping"]
            }
            initial_delay_seconds = 3
            period_seconds        = 10
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "redis" {
  metadata {
    name      = "redis"
    namespace = "apache-fineract"
  }

  spec {
    selector = {
      app = "redis"
    }
    nnotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type" = "internal"
      "service.beta.kubernetes.io/aws-load-balancer-scheme" = "internal"
    }

    type = "LoadBalancer"

    port {
      protocol    = "TCP"
      port        = 443
      target_port = 443
    }
  }
}