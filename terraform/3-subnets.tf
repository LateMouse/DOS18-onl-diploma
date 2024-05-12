## Описывает создание подсети в Google Compute Engine с именем "private", диапазон IP-адресов "10.0.0.0/18" 
## и доступ к службам Google через внутренние IP-адреса будет разрешен. 
## Кроме того, в подсети определены дополнительные диапазоны IP-адресов для использования в Kubernetes-кластере:
##      name - определяет имя подсети
##      ip_cidr_range - задает диапазон IP-адресов для подсети
##      region - определяет регион, в котором будет создана подсеть
##      network - указывает на идентификатор сети, к которой принадлежит подсеть. 
##                Используется значение идентификатора сети google_compute_network.main.id определенного в 2-vpc.tf
##      private_ip_google_access - разрешен ли доступ к службам Google с внутренними IP-адресами в этой подсети
##      secondary_ip_range - дополнительные диапазоны IP-адресов для подсети
##                Эти дополнительные диапазоны будут использованы для размещения подов и сервисов в Kubernetes-кластере

resource "google_compute_subnetwork" "private" {
    name                        = "private"
    ip_cidr_range               = "10.0.0.0/18"
    region                      = var.region
    network                     = google_compute_network.main.id
    private_ip_google_access    = true

    secondary_ip_range {
        range_name      = "k8s-pod-range"
        ip_cidr_range   = "10.48.0.0/14"
    }
    secondary_ip_range {
        range_name      = "k8s-service-range"
        ip_cidr_range   = "10.52.0.0/20"
    }
}