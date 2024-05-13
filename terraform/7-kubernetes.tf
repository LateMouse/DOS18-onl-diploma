## Настройка кластера Kubernetes в Google Kubernetes Engine. 
## Кластер будет создан с одним узлом, подключен к указанным сети и подсети, и будет настроен с использованием определенных конфигураций, 
## таких как отключение дополнений, настройка идентификации нагрузки и приватного кластера.

##  resource "google_container_cluster" "primary" - определяет ресурс "google_container_cluster" с именем "primary", который представляет кластер Kubernetes
##  name - имя кластера
##  location - расположение кластера
##  remove_default_node_pool - следует ли удалить исходный пул узлов, создаваемый по умолчанию
##  initial_node_count - начальное количество узлов в кластере
##  network - имя сети, к которой применяется кластер, представляет ссылку на ресурс сети с именем "main" файла 2-vpc.tf
##  subnetwork - имя подсети, к которой применяется кластер, редставляет ссылку на ресурс подсети с именем "private файла 3-subnets.tf
##  logging_service - сервис регистрации, который будет использоваться для кластера Kubernetes
##  monitoring_service - cервис мониторинга, который будет использоваться для кластера Kubernetes
##  networking_mode - режим сетевых подключений кластера. В данном случае, установлено значение "VPC_NATIVE", что означает использование нативного режима VPC.
##  node_locations - список местоположений, где будут размещены узлы кластера Kubernetes как резервной площадки

resource "google_container_cluster" "primary" {
  name                     = "primary"
  location                 = var.zone
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.main.self_link
  subnetwork               = google_compute_subnetwork.private.self_link
  networking_mode          = "VPC_NATIVE"

  node_locations = [
    "europe-west3-a"
  ]

  ##  addons_config - конфигурация дополнений к кластеру Kubernetes
  ##      http_load_balancing - балансировка нагрузки HTTP. В данном случае, отключение балансировки нагрузки HTTP.
  ##      horizontal_pod_autoscaling - горизонтальное масштабирование подов

  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = true
    }
  }

  ##  release_channel - канал выпуска для обновлений Kubernetes. 
  ## Каналы выпуска GKE обычно представлены следующим образом:
  ##  REGULAR: предоставляет стабильные и широко протестированные версии Kubernetes.
  ##  RAPID: предлагает более новые версии Kubernetes, которые прошли некоторую степень тестирования. 
  ##  STABLE: предлагает более старые, но очень стабильные версии Kubernetes. 
  release_channel {
    channel = "REGULAR"
  }

  ##  workload_identity_config - конфигурация идентификации нагрузки
  workload_identity_config {
    workload_pool = "latemouse.svc.id.goog"
  }

  ##  ip_allocation_policy - политика выделения IP-адресов.
  ##      cluster_secondary_range_name: Определяет имя дополнительного диапазона IP-адресов для подов.
  ##      services_secondary_range_name: Определяет имя дополнительного диапазона IP-адресов для сервисов.

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-range"
    services_secondary_range_name = "k8s-service-range"
  }

  ##  private_cluster_config - Конфигурация приватного кластера
  ##      enable_private_nodes: следует ли включить приватные узлы
  ##      enable_private_endpoint: следует ли включить приватную конечную точку
  ##      master_ipv4_cidr_block: блок IPv4-адресов для мастер-узлов

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }
}