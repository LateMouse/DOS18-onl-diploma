## Cоздание маршрутизатора в Google Compute Engine. Он будет иметь имя "router" и будет принадлежать к сети с идентификатором "google_compute_network.main.id" определенного в 2-vpc.tf
##      name - имя маршрутизатора
##      region - регион, в котором будет создан маршрутизатор
##      network - идентификатор сети, к которой принадлежит маршрутизатор

resource "google_compute_router" "router" {
  name      = "router"
  region    = var.region
  network   = google_compute_network.main.id
}