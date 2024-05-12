## Код описывает настройку NATдля маршрутизатора в Google Compute Engine. 
## Он создает настройку NAT с именем "nat" для указанного маршрутизатора. 
## Настройка NAT будет применяться к определенным подсетям и будет использовать выделенный IP-адрес с именем "nat".

##  name - имя настройки NAT
##  router - имя маршрутизатора, к которому применяется настройка NAT
##  region - регион, в котором создается настройка NAT
##  source_subnetwork_ip_ranges_to_nat - список подсетей, для которых будет применена NAT. Значение "LIST_OF_SUBNETWORKS", означает список подсетей, которые должны быть настроены для NAT.
##  nat_ip_allocate_option - задает опцию выделения IP-адресов для NAT. Значение "MANUAL_ONLY", что означает, что IP-адреса для NAT будут выделяться только вручную.
##  subnetwork - подсеть, которая будет настроена для NAT. В данном случае, указано имя подсети google_compute_subnetwork.private.id,
##               которое указывает на ресурс подсети с именем "private". Также указано, что все IP-диапазоны в этой подсети должны быть настроены для NAT.
##  nat_ips - писок IP-адресов, которые будут использоваться для NAT. Здесь указано значение [google_compute_address.nat.self_link], 
##            что означает, что IP-адрес, созданный с помощью ресурса google_compute_address с именем "nat", будет использоваться для NAT.

resource "google_compute_router_nat" "nat" {
    name                                = "nat"
    router                              = google_compute_router.router.name
    region                              = var.region

    source_subnetwork_ip_ranges_to_nat  = "LIST_OF_SUBNETWORKS"
    nat_ip_allocate_option              = "MANUAL_ONLY"

    subnetwork {
      name                      = google_compute_subnetwork.private.id
      source_ip_ranges_to_nat   = ["ALL_IP_RANGES"]
    }
  
  nat_ips   = [google_compute_address.nat.self_link]
}

##  resource "google_compute_address" "nat" - определяет ресурс "google_compute_address" с именем "nat", который представляет собой выделенный IP-адрес для использования в NAT.
##  address_type - тип выделенного IP-адреса. "EXTERNAL", означает, что IP-адрес будет внешним (для доступа извне).
##  network_tier - уровень сети для выделенного IP-адреса. 
##       В GCP существуют два уровня сети:
##                  Стандартный (Standard): бесплатный уровень сети, который предоставляется по умолчанию. 
##                  Он обеспечивает базовый уровень производительности и доступности сети.
##                  Премиум (Premium): платный уровень сети, который обеспечивает повышенную производительность сети и более низкую задержку. 
##                  Он предлагает более высокую пропускную способность, низкую задержку и повышенную надежность для приложений с высокими требованиями к сетевой производительности.
##  depends_on - зависимость данного ресурса от других ресурсов. В данном случае, указана зависимость от активации службы "compute.googleapis.com". Это гарантирует, что активация службы будет выполнена перед созданием выделенного IP-адреса для NAT.

resource "google_compute_address" "nat" {
    name            = "nat"
    address_type    = "EXTERNAL"
    network_tier    = "STANDARD"

    depends_on      = [google_project_service.compute]
}