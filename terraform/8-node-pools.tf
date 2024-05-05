## Код определяет два ресурса:
##      google_service_account - представляет сервисный аккаунт GCP, который будет использоваться для управления ресурсами Kubernetes.
##      google_container_node_pool - представляет пул узлов Kubernetes, который будет создан в рамках кластера Kubernetes. В коде определены два пула узлов:
##          "general" предназначен для общего использования и содержит один узел. Узел будет создан с указанными параметрами конфигурации, включая тип машины и сервисный аккаунт.
##          "spot" предназначен для использования виртуальных машин. Он использует автомасштабирование и может иметь от 0 до 10 узлов. 
##                  Конфигурация узла также указывает тип машины, сервисный аккаунт и определяет аннотацию "taint", 
##                  которая помечает узлы как "spot" и применяет эффект "NO_SCHEDULE". 
##                  Это означает, что поды не будут планироваться на эти узлы, если они не явно требуют использование таких узлов.
##
##      Оба пула узлов настроены на автоматическое восстановление и автоматическое обновление. 
##      Они также имеют разрешение на доступ к Google Cloud Platform через определенные oauth-области видимости.


resource "google_service_account" "kubernetes" {
  account_id = "kubernetes"
}


##  resource "google_container_node_pool" "general" - пул узлов в кластере Kubernetes
##  name - имя пула узлов.
##  cluster - идентификатор кластера, к которому принадлежит пул узлов. 
##  node_count - количество узлов в пуле. В данном случае, установлено значение 1.
##  management - Конфигурация управления пулом узлов.
##          auto_repair: следует ли включить автоматическое восстановление узлов.
##          auto_upgrade: следует ли включить автоматическое обновление узлов.
##
##  node_config - конфигурация узлов пула.
##          preemptible: следует ли использовать предварительно выделенные узлы
##          machine_type: тип машины для узлов пула.
##
##  labels - устанавливает метки для узлов пула.
##  service_account - сервисный аккаунт, который будет использоваться узлами пула.
##  oauth_scopes - список OAuth-областей видимости для узлов пула. Установлено значение ["https://www.googleapis.com/auth/cloud-platform"], что означает использование области видимости Cloud Platform.


resource "google_container_node_pool" "general" {
  name = "general"
  cluster = google_container_cluster.primary.id
  node_count = 1

  management {
    auto_repair = true
    auto_upgrade = true
  }

  node_config {
    preemptible = false
    machine_type = var.machine_type

    labels = {
      role = "general"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}


##  resource "google_container_node_pool" "spot" - определяет ресурс который представляет пул узлов в кластере Kubernetes.
##  name - имя пула узлов.
##  cluster - идентификатор кластера, к которому принадлежит пул узлов.
##  management - Конфигурация управления пулом узлов.
##          auto_repair: следует ли включить автоматическое восстановление узлов.
##          auto_upgrade: следует ли включить автоматическое обновление узлов.
##
##  autoscaling - конфигурация автомасштабирования пула узлов.
##          min_node_count: минимальное количество узлов в пуле при автомасштабировании.
##          max_node_count: максимальное количество узлов в пуле при автомасштабировании.
##
##  node_config - конфигурация узлов пула.
##      preemptible: следует ли использовать предварительно выделенные узлы.
##      machine_type: тип машины для узлов пула.
##  labels - метки для узлов пула
##  taint - аннотация для узлов пула.
##          key: идентифицирует атрибут, который будет помечен. В данном случае, ключ "instance_type" указывает что атрибут taint будет применен к ресурсу, связанному с типом экземпляра.
##          value: значение, которое будет связано с ключом "instance_type".
##          effect: указывает как должна обрабатываться пометка (taint) ресурса. В данном случае "NO_SCHEDULE" означает, 
##                  что помеченный ресурс не будет планироваться или создаваться при выполнении операций планирования или применения Terraform. 
##
##  service_account - сервисный аккаунт, который будет использоваться узлами пула
##  oauth_scopes - список OAuth-областей видимости для узлов пула. 

resource "google_container_node_pool" "spot" {
  name = "spot"
  cluster = google_container_cluster.primary.id

  management {
    auto_repair = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 0
    max_node_count = 10
  }

  node_config {
    preemptible = true
    machine_type = var.machine_type

    labels = {
      team = "devops"
    }

    taint {
      key = "instance_type"
      value = "spot"
      effect = "NO_SCHEDULE"
    }

        service_account = google_service_account.kubernetes.email
    oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}