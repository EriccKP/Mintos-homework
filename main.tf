resource "helm_release" "postgresql" {
  name       = "postgresql"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  namespace  = kubernetes_namespace.sonarqube.metadata[0].name

  set {
    name  = "auth.username"
    value = "sonarqube"
  }

  set {
    name  = "auth.password"
    value = "sonarPass123" # replace with secret later 
  }

  set {
    name  = "auth.database"
    value = "sonarqube"
  }

  set {
    name  = "persistence.enabled"
    value = "true"
  }

}


resource "kubernetes_namespace" "sonarqube" {
  metadata {
    name = "sonarqube"
  }
}

# Deploy SonarQube
resource "helm_release" "sonarqube" {
  name       = "sonarqube"
  repository = "https://oteemo.github.io/charts"
  chart      = "sonarqube"
  namespace  = kubernetes_namespace.sonarqube.metadata[0].name

  depends_on = [helm_release.postgresql]

  set {
    name  = "resources.requests.memory"
    value = "1024Mi"
  }

  set {
    name  = "persistence.enabled"
    value = "true"
  }

  set {
    name  = "postgresql.enabled"
    value = "false"
  }

  set {
    name  = "postgresql.postgresqlServer"
    value = "postgresql"
  }

  set {
    name  = "postgresql.postgresqlUsername"
    value = "sonarqube"
  }

  set {
    name  = "postgresql.postgresqlPassword"
    value = "sonarPass123"
  }

  set {
    name  = "postgresql.postgresqlDatabase"
    value = "sonarqube"
  }

  set {
    name  = "jdbcUrlOverride"
    value = "jdbc:postgresql://postgresql:5432/sonarqube"
  }

  set {
    name  = "ingress.enabled"
    value = "true"
  }

  set {
    name  = "ingress.className"
    value = "nginx"  
  }

  set {
    name  = "ingress.hosts[0].name"
    value = "sonarqube.local"  
  }

  set {
    name  = "ingress.hosts[0].path"
    value = "/" 
  }

  set {
    name  = "ingress.hosts[0].pathType"
    value = "Prefix"
  }
}
