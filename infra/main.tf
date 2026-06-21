terraform {

  required_providers {

    kubernetes = {

      source = "hashicorp/kubernetes"

      version = "~> 2.35"

    }

  }

}

provider "kubernetes" {

  config_path = "~/.kube/config"

}

resource "kubernetes_namespace" "dev" {

  metadata {

    name = "dev"

  }

}

resource "kubernetes_namespace" "hml" {

  metadata {

    name = "hml"

  }

}