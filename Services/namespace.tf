
resource "kubernetes_namespace" "apache-fineract" {
  metadata {
    name = "apache-fineract"
  }
}

