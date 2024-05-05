# DOS18-onl-diploma
## Выпускной проект TeachMeSkills группы DOS18-Onl 
## Остриков Андрей Яковлевич

### 1. Общее описание проекта:
1. Посредством Terrrafom cоздается GKE кластер

### 2. Используемые технологии:

| Технология | Название | Версия |
| ----- | ----- | ----- |
| IaC  | Terraform | 1.7.4 |
| Cloud Provider | Google Cloud Platform | - |


### 3.Предварительные настройки

#### 3.1 Terraform:
3.1.1. создание Service Account Trerraform и .jcon ключа для подключения к GCP: <br> <br>

![изображение](https://github.com/LateMouse/DOS18-onl-diploma-LateMouse/assets/114028634/362c22fb-8e8e-4b0f-8c91-451014d6bd56) <br> <br>

![изображение](https://github.com/LateMouse/DOS18-onl-diploma-LateMouse/assets/114028634/58fbac61-9dda-4cc2-ae2b-1e9d0efcc50d) <br> <br>

![изображение](https://github.com/LateMouse/DOS18-onl-diploma-LateMouse/assets/114028634/06d09a47-7668-485b-936c-9c527c9f19ae) <br> <br>

![изображение](https://github.com/LateMouse/DOS18-onl-diploma-LateMouse/assets/114028634/4b91d01f-522e-4901-8467-1cab1337463b) <br> <br>

![изображение](https://github.com/LateMouse/DOS18-onl-diploma-LateMouse/assets/114028634/ee3fc389-29c3-42ec-b330-3c9dc539ad80) <br> <br>

![изображение](https://github.com/LateMouse/DOS18-onl-diploma-LateMouse/assets/114028634/658db911-40c7-4023-ba8a-b0dce48610d8) <br> <br>

![изображение](https://github.com/LateMouse/DOS18-onl-diploma-LateMouse/assets/114028634/a53b65cc-58ac-4929-948c-1e886c526b77) <br> <br>

![изображение](https://github.com/LateMouse/DOS18-onl-diploma-LateMouse/assets/114028634/8756363b-9513-4a6b-bcce-80bdf95f49df) <br> <br>



3.1.2. Вручную созданим backet для хранения состояния файла terraform:

![изображение](https://github.com/LateMouse/DOS18-onl-diploma-LateMouse/assets/114028634/7b881f69-6956-4e81-b902-ff9eddf7d2a6) <br> <br>

![изображение](https://github.com/LateMouse/DOS18-onl-diploma-LateMouse/assets/114028634/d05e381d-2102-4796-a490-5dd5dc456e63) <br> <br>

![изображение](https://github.com/LateMouse/DOS18-onl-diploma-LateMouse/assets/114028634/b9d611b7-7eeb-4fa1-9f4e-4b607c53c452) <br> <br>

![изображение](https://github.com/LateMouse/DOS18-onl-diploma-LateMouse/assets/114028634/b5df3e1f-45f9-431c-ae74-178f73f0e19c) <br> <br>

![изображение](https://github.com/LateMouse/DOS18-onl-diploma-LateMouse/assets/114028634/b44aced6-abd6-475f-9341-27e883a8a02a) <br> <br>

![изображение](https://github.com/LateMouse/DOS18-onl-diploma-LateMouse/assets/114028634/278293ec-31fc-45b2-9e08-943fe4af97e4) <br> <br>


3.1.3. Экпортируем ключ в переменную среды

```bash
export GOOGLE_APPLICATION_CREDENTIALS=<путь к файлу>/googlecloud-credential.json 
```

4. 

## Выполнение работы:
### Созданиек инфраструктуры.
Описание инфраструктуры представляет из себя 10 файлов terraform:
В данной части проекта создается VPC с нуля с помощью Terraform. <br>
Будет созданы две группы instance: одна для общих служб и вторая которая будет использовать spot instance (Spot instances представляют собой вычислительные ресурсы, которые доступны по значительно более низкой цене по сравнению с обычными экземплярами типа On-Demand (по запросу) или Reserved (зарезервированными). Spot instances основаны на концепции ценообразования на аукционной основе.) и будут иметь соответствующие теги и метки. <br>
Будет настроена автоматичекое масштабирование для кластера Kubernetis и использоватся идентификатор workloads. <br>


![изображение](https://github.com/LateMouse/DOS18-onl-diploma-LateMouse/assets/114028634/6cc782c6-afa4-4898-ae4a-fb53e3287f90) <br> <br>


| Название файла | Описание |
| ----- | ----- |
| 0-variables.tf | Определены переменные, которые будут использоваться в других файлах конфигурации. Каждая переменная имеет описание и значение по умолчанию. "project_id" представляет собой идентификатор проекта в Google Cloud, "region" - регион, а "zone" - зону, в которой будут разворачиваться ресурсы. "machine_type" указывает на тип машины, который будет использоваться. |
| 1-provider.tf  | Определен провайдер "google", который будет использоваться для взаимодействия с Google Cloud. Используются значения переменных "project_id", "region" и "zone" для идентификации проекта, региона и зоны в Google Cloud.|
| 2-vpc.tf | Определены ресурсы для создания виртуальной частной сети (VPC) в Google Cloud. Сначала создаются ресурсы "google_project_service", которые активируют службы Compute Engine и Google Kubernetes Engine в проекте. Затем создается ресурс "google_compute_network", который представляет собой основную сеть с именем "main". Указаны различные настройки, такие как режим маршрутизации, автоматическое создание подсетей и другие. Зависимость от активации служб гарантирует, что службы будут активированы перед созданием сети. |
| 3-subnets.tf | Определен ресурс "google_compute_subnetwork", который представляет собой подсеть внутри виртуальной частной сети. Подсеть имеет имя "private" и диапазон IP-адресов "10.0.0.0/18". Она привязана к основной сети, определенной в файле "2-vpc.tf". Установлен флаг "private_ip_google_access", чтобы разрешить доступ к службам Google из внутренних IP-адресов подсети. Также определены два дополнительных диапазона IP-адресов для использования в подсети - "k8s-pod-range" и "k8s-service-range". |
| 4-router.tf | Ресурс "google_compute_router", который представляет собой маршрутизатор в Google Cloud. Маршрутизатор имеет имя "router" и привязан к основной сети, определенной в файле "2-vpc.tf" |
| 5-nat.tf | Определены два ресурса. Ресурс "google_compute_router_nat" представляет собой настройки Network Address Translation (NAT) для маршрутизатора. Он имеет имя "nat" и привязан к маршрутизатору, определенному в файле "4-router.tf". Заданы настройки преобразования IP-адресов для подсетей и опция выделения IP-адресов NAT. Также указана подсеть, для которой будет использоваться NAT, и диапазон IP-адресов, которые будут преобразованы. Указан также ресурс "google_compute_address", который представляет собой внешний IP-адрес, который будет использоваться для NAT. Указаны его имя, тип адреса и уровень сети. |
| 6-firewalls.tf | Определен ресурс "google_compute_firewall", который представляет собой правило брандмауэра в Google Cloud. Брандмауэр имеет имя "allow-ssh" и применяется к основной сети, определенной в файле "2-vpc.tf". Указано разрешение для протокола TCP и порта 22 (SSH). Указан диапазон источников, в данном случае "0.0.0.0/0", что означает, что доступ разрешен со всех IP-адресов. |
| 7-kubernetes.tf | Определен ресурс "google_container_cluster", который представляет собой кластер Kubernetes в Google Cloud. Кластер имеет имя "primary". Указаны различные настройки, такие как количество начальных узлов, сеть и подсеть, в которых будет развернут кластер.  |
| 8-node-pools.tf | Определены ресурсы для управления узлами (node pool) в кластере Kubernetes. Ресурс "google_service_account" создает сервисный аккаунт с идентификатором "kubernetes". Затем определены два ресурса "google_container_node_pool" - "general" и "spot". "general" представляет обычный узел с одним экземпляром, а "spot" представляет узел с возможностью прерывания работы и масштабированием. Узлы настроены для автоматического восстановления и обновления. Они также связаны с сервисным аккаунтом Kubernetes |
| 9-service-account.tf | В файле создается ресурс "google_service_account", который представляет сервисный аккаунт в Google Cloud. Сервисный аккаунт имеет идентификатор "service-a".  Определен ресурс "google_project_iam_member", который устанавливает членство сервисного аккаунта в проекте Google Cloud. Роль "roles/storage.admin" назначается аккаунту. |

##### 1-provider.tf (определение провайдера):
Прежде всего нам требуется указать поставшика Terraform, в данном случае это Google Cloud. Идентификация проекта и регион поставщика берут значения переменных из файла 0-variables.tf. <br>
Дополнительно создаем удаленное хранилище для хранения состояния Terraform в bucket GCP, созданном п. 3.1.2. и указываем ограничения на версию поставщика.

```hcl
## Определен провайдер "google", который используется для взаимодействия с Google Cloud. 
## Указываются настройки провайдера, такие как идентификатор проекта ("project_id"), регион ("region") и зона ("zone"). 
# Значения для этих настроек берутся из переменных, определенных в файле 0-variables.tf
provider "google" {
  project       = var.project_id
  region        = var.region
  zone          = var.zone
}

## В этом блоке определены настройки Terraform. 
## В блоке "backend" указывается использование Google Cloud Storage в качестве удаленного хранилища состояния Terraform. 
## Задается имя bucket и префикс для состояния Terraform. 
## В блоке "required_providers" указывается требуемый провайдер для этой конфигурации Terraform.
## В данном случае, это провайдер "google" от HashiCorp с версией, указанной как "~> 5.27". 
terraform {
  backend "gcs" {
    bucket      = "dos18-onl-tf-state-staging"
    prefix      = "terraforn/state"  
  }
  required_providers {
    google = {
        source  = "hashicorp/google"
        version = "~> 5.27"
    }
  }
}

```

##### 2-vpc.tf (создание VPC):
Прежде чем создать VPN нам необходимо включить compute API 
Чтобы создать кластер GKE, на так же необходимо включит container API
После можно создавать сам VPC с режимом маршрутизации. В данном случае выбран REGIONAL, что означает что маршрутизаторы этой сети будут анонсировать маршруты только с подсетями этой сети в том же регионе, что и маршрутизатор. В случае если выбран GLOBAL, маршрутизаторбы будут анонсировать маршруты со всеми подсетями в разных регионах. С утсановкой MTU в 1460 (максимальная единица передачи в сети в байтах).
```hcl
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
```

##### 3-subnets.tf (создание подсетей для k8s):
Создаем подсети для размещения узлов Kubernetes. Когда мы используем кластер GKE, control plane управляется Google и нам нужно беспокоится только о размещеннии worker.
Дополнительно указываем дополнительные диапазоны адресов - узлы Kubernetes будут использовать ip-адреса из основного диапазона CIDE, но модули Kubernetes будут использовать IP-адреса из дополнительных диапазонов. В случае если нам потребуется открыть брандмауэр для доступа к другим VM в нашем VPC из Kubernetes, нам потребуется использовать дополнительный диапазон в качестве источника. <br>
Второй дополнительный диапазон IP-адресов используется для назначения IP-адресов для ClusterIP в Kubernetes. Когда мы будем создавать Service в Kubernetes, IP-адрес будет взят из этого диапазона.
```hcl
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
```


##### 4-router.tf (создание маршрутизатора):
Создаем маршрутизатор для анонса маршрутов. Он будет использоватся вместе со шлюзом NAT, чтобы позволить VM без общедоступных IP-адресов получать доступ в сеть ИНтернет (например для извлечения образов docker из docker hub) <br>
```hcl
## Cоздание маршрутизатора в Google Compute Engine. Он будет иметь имя "router" и будет принадлежать к сети с идентификатором "google_compute_network.main.id" определенного в 2-vpc.tf
##      name - имя маршрутизатора
##      region - регион, в котором будет создан маршрутизатор
##      network - идентификатор сети, к которой принадлежит маршрутизатор

resource "google_compute_router" "router" {
  name      = "router"
  region    = var.region
  network   = google_compute_network.main.id
}
```

##### 5-nat.tf (создание NAT):
Даем ссылку на маршрутизатор созданным в прошлом пункте и даем анонс только частных подсетей VPC. Устанавливаем настройку чтобы Google выделял и назначал IP-адрес для нашего NAT для доступа извне. Поскольку мы сами распределяем внешине IP-адреса, мы указываем их в поле net-ips. 
```hcl
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
```
##### 6-firewalls.tf (создание брандмауэра):
Созаем правило для полкючения к нашим instance внутри VPC по ssh
```hcl
## Настройка правила брандмауэра для разрешения SSH-соединений в Google Compute Engine.
## Правило брандмауэра будет применяться к указанной сети и разрешать входящие TCP-соединения на порт 22 (SSH) с любых IP-адресов источников.

##  resource "google_compute_firewall" "allow-ssh" - определяет ресурс "google_compute_firewall" с именем "allow-ssh", который представляет собой правило брандмауэра для разрешения SSH-соединений
##  name - имя правила брандмауэра
##  network - имя сети, к которой применяется правило брандмауэра. Используется значение имени сети google_compute_network.main.name, которое указывает на ресурс сети с именем "main"
##  allow - список разрешенных протоколов и портов для данного правила брандмауэра.
##        protocol: Указывает на протокол, который будет разрешен. В данном случае "tcp".
##        ports: Определяет список портов, которые будут разрешены. В данном случае будет разрешен SSH-порт.
##  source_ranges - писок диапазонов IP-адресов источников, с которых разрешены соединения. В данном случае разрешены соединения с любых IP-адресов источников.


resource "google_compute_firewall" "allow-ssh" {
    name    = "allow-ssh"
    network = google_compute_network.main.name
  
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}
```
##### 7-kubernetes.tf (создание кластера Kubernetes)
В данном разделе необходимо настроить управление кластером. Устанавливаем удаление пула узлов по умолчанию, поскольку мы создадим дополнительные группы экземпляров для кластера, исходное состояние узла не будет иметь значение, так как оно все равно будет уничтожено. Дополнительно создаем еще одну зону доступности на случай выхода из строя control plane. Балансировку нагрузки отключаем по причине того, что будет использоваться иные метобы балансировки.
```hcl
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
##  networking_mode - режим сетевых подключений кластера. В данном случае, установлено значение "VPC_NATIVE", что означает использование нативного режима VPC.
##  node_locations - список местоположений, где будут размещены узлы кластера Kubernetes как резервной площадки

resource "google_container_cluster" "primary" {
  name                      = "primary"
  location                  = var.zone
  remove_default_node_pool  = true
  initial_node_count        = 1
  network                   = google_compute_network.main.self_link
  subnetwork                = google_compute_subnetwork.private.self_link
  networking_mode           = "VPC_NATIVE"

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
## В данном случае, установлено значение "channel = "REGULAR"", что означает использование регулярного канала выпуска.
  release_channel {
    channel = "REGULAR"
  }

##  workload_identity_config - конфигурация идентификации нагрузки
  workload_identity_config {
    workload_pool = "dos18-onl.svc.id.goog"
  }

##  ip_allocation_policy - политика выделения IP-адресов.
##      cluster_secondary_range_name: Определяет имя дополнительного диапазона IP-адресов для подов.
##      services_secondary_range_name: Определяет имя дополнительного диапазона IP-адресов для сервисов.

  ip_allocation_policy {
    cluster_secondary_range_name    = "k8s-pod-range"
    services_secondary_range_name   = "k8s-service-range"
  }

##  private_cluster_config - Конфигурация приватного кластера
##      enable_private_nodes: следует ли включить приватные узлы
##      enable_private_endpoint: следует ли включить приватную конечную точку (включается в случае использования VPN)
##      master_ipv4_cidr_block: блок IPv4-адресов для мастер-узлов

  private_cluster_config {
    enable_private_nodes        = true
    enable_private_endpoint     = false
    master_ipv4_cidr_block      = "172.16.0.0/28"
    }
  }
```

##### 8-node-pools.tf (создание нод):
Создаем две группы узлов: <br>
- первая является общей, без ограничений для запуска компонентов кластера. В данной группе отключаем автоматическое масштабирование, поэтому указываем сколько узлов мы хотим видеть
- вторая группа, spot, указываем автоматическое масштабирование, и указываем preemptible в значение true, то есть будут использоваться более дешевые VM, но Google может их забрать в любой момент и они работают до 24 часов.

```hcl
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
```
##### 9-service-account.tf 
```hcl
Для использования сервисных учетных записей в кластере создаем дополнительные аккаутны, которые будут использоватся в кластере для выполнения команд.
resource "google_service_account" "service-a" {
  account_id = "service-a"
}

resource "google_project_iam_member" "service-a" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.service-a.email}"
}

resource "google_service_account_iam_member" "service-a" {
  service_account_id = google_service_account.service-a.id
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:dos18-onl.svc.id.goog[staging/service-a]"
}
```
