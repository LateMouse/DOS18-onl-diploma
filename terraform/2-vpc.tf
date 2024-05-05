## Определяется ресурс "google_project_service" с именем "compute". 
## Этот ресурс представляет собой активацию службы Google Compute Engine в проекте.
## Указывается служба "compute.googleapis.com", которая предоставляет возможности виртуальных машин и инфраструктуры облачных вычислений Google Cloud.
resource "google_project_service" "compute" {
    service = "compute.googleapis.com"
}

## Определяется ресурс "google_project_service" с именем "container". 
## Этот ресурс представляет собой активацию службы Google Kubernetes Engine в проекте. 
## Указывается служба "container.googleapis.com", которая предоставляет возможности управления 
## контейнеризированными приложениями с использованием Kubernetes на Google Cloud.
resource "google_project_service" "container" {
  service = "container.googleapis.com"
}

## Определяется ресурс "google_compute_network" с именем "main". 
## Ресурс представляет собой создание сети Google Compute Engine в проекте. 
## Задаются следующие параметры сети:
##      name - имя сети
##      routing_mode - режим маршрутизации. Значение "REGIONAL" указывает, что маршрутизация будет осуществляться на уровне региона.
##      auto_create_subnetworks - возможность автоматического создания подсетей 
##      MTU - максимальный размер единицы передачи 
##      delete_default_routes_on_create - будут ли удалены маршруты по умолчанию при создании сети. Установленное значение "false" указывает, что маршруты по умолчанию не будут удалены.

resource "google_compute_network" "main" {
    name                            = "main"
    routing_mode                    = "REGIONAL"
    auto_create_subnetworks         = false
    mtu                             = 1460
    delete_default_routes_on_create = false

## указываются зависимости от других ресурсов. 
## В данном случае, сеть "main" зависит от активации служб "compute.googleapis.com" и "container.googleapis.com". 
## Таким образом, перед созданием сети будут активированы необходимые службы.
    depends_on = [ 
        google_project_service.compute,
        google_project_service.container
    ]
}