terraform {
  required_providers {
    kubernetes = {

      source  = "hashicorp/kubernetes"
      version = "2.23.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"  # Path to your Kubernetes configuration file
}


resource "kubernetes_deployment" "apachedeployment" {
  metadata {
    name      = "apache-deployment"
    namespace ="roberto"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "apache"
      }
    }

    template {
      metadata {
        labels = {
          app = "apache"
        }
      }

      spec {
        container {
          name  = "apache"
          image = "httpd:latest"  # Replace with your desired Apache2 image

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "apacheservice" {
  metadata {
    name      = "apache-service"
    namespace = "roberto"
  }

  spec {
    selector = {
      app = "apache"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}