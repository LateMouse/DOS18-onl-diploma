## Выпускной проект TeachMeSlills
Курс: _DevOps инженер_ <br>
Группа: _DOS18-onl_ <br>
Студент: _Остриков Андрей Яковлевич_ <br>

### 0. Требования к дипломному проекту:
```markdown
ТРЕБОВАНИЯ К ДИПЛОМНОМУ ПРОЕКТУ

В дипломном проекте должно быть реализовано:
* выбран общедоступный репозиторий или несколько репозиториев с исходным кодом приложения,
состоящего из одного или нескольких микросервисов;
* выполнен fork или сделана копия репозитория;
* автоматизировано создание инфраструктуры для развертывания проекта;
* автоматизированы процессы CI/CD;
* настроен мониторинг инфраструктуры и приложения.

Критерии выполнения:
* Репозитории должен содержать минимальную документацию, описывающую
содержимое и процессы сборки и развертывания;
* Инфраструктура должна разворачиваться с нуля запуском одной команды.
Все должно быть реализовано по принципам IaC;
* CI/CD:
    o при коммите в любую ветку репозитория должны запускаться этапы проверки кода линтером, сборки исходного кода,
автотесты собранного приложения и загрузка артефактов в хранилище;
    o при коммите в основную ветку (master/main) дополнительно должен запускаться
автоматический deployment на целевую инфраструктуру;
    o Должно отправляться уведомление о результате сборки и развертывания в любой
канал (почта, чат).

Дополнительные (опциональные) варианты улучшения проекта:
* Реализация SSL/TLS;
* Масштабируемость (несколько реплик одного сервиса с балансировщиком);
* Контейнеризация;
* Kubernetes в качестве целевой инфраструктуры;
* Больше типов и количества тестов (интеграционное, нагрузочное и пр.);
* Автоматическая настройка всего (включая CI\CD, мониторинг) с нуля;
* Мониторинг инфраструктуры и приложения;
* Реализация Log-aggregation;
* Документированный код.

Применяемые инструменты:
* Развертывание инфраструктуры: Terraform, AWS, EKS, Ansible, Docker, Vagrant;
* CI/CD: Jenkins, Github Actions;
* Оповещение: Email, Telegram, Slack, Discord;
* Мониторинг: Prometheus, Grafana;
* Логирование: ELK.

Защита проекта:
* Краткая презентация с описанием проекта, примененными инструментами, проделанной работы
и полученными результатами (3-5 мин.);
* Демонстрация CI/CD (10-12 мин.);
* Вопросы и обсуждение (5-7 мин.).

Примеры репозиториев приложений:
* Golang Hello World
https://github.com/hackersandslackers/golang-helloworld
* Sample app maven
https://github.com/jenkins-docs/simple-java-maven-app
* Sample app gradle
https://github.com/jitpack/gradle-simple
https://github.com/jhipster/jhipster-sample-app-gradle
* Calculator App
https://github.com/HouariZegai/Calculator
```

### 1. Используемые инструменты:
- Docker
- Docker Compose
- Docker Hub
- Google Cloud Platform
- Google Kubernetis Engine
- Terraform
- GitHub
- GitHub Actions

### 2. Общее описание проекта:
Общая топология проекта: <br>
![Topologi](https://github.com/LateMouse/DOS18-onl-diploma/assets/114028634/f45ee7da-fc44-4127-b15e-44f5cc187ced) <br> <br>

Проект состоит из двух веток: main и dev. <br>
#### [Ветка dev]:
Ветка dev предназначена исключительно для проверки внесенных изменений и не влияет на активный проект. При коммите в ветку dev выполняются следующие шаги: <br> <br>

- Осуществляется проверка с использованием Linter конфигурационных файлов terraform, dockerfile и yaml.
- Устанавливаются необходимые инструменты для тестирования приложения, такие как terraform, Docker Compose и Google Cloud CLI.
- В директории, содержащей файлы terraform, инициализируются провайдеры и загружаются основные модули для создания инфраструктуры с помощью команды "terraform init".
- Осуществляется просмотр плана изменений, которые планируется применить Terraform к инфраструктуре с помощью команды "terraform plan".
- Создается Docker-образ на основе указанного в Dockerfile файла.
- С помощью Docker Compose запускается контейнер из созданного образа.
- Производится проверка путем отправки HTTP-запросов к контейнеру Docker. Если возвращаемый HTTP-код равен 200, проверка считается успешной.
- Контейнер останавливается, а Docker-образ удаляется.
- Создается Docker-образ на основе указанного в Dockerfile файла.
- Образ загружается в репозиторий Docker Hub.
- Выполняется предварительная проверка авторизации на Docker Hub для возможности загрузки образа в репозиторий.
- Отправляются уведомления в Telegram о новом коммите, внесенном в ветку.

<br>

#### [Ветка main]:
Ветка main имеет непосредственное влияние на активный процесс развертывания инфраструктуры в облачном провайдере и конфигурацию, а также на публикацию приложения в облаке. Запуск GitHub Actions происходит при коммите в основную ветку (main) или при слиянии (merge) dev ветки с основной. В процессе выполнения запуска GitHub Actions выполняются следующие шаги:

- Осуществляется проверка с использованием линтера для конфигурационных файлов terraform, dockerfile и yaml.
- Устанавливаются необходимые инструменты для тестирования приложения, такие как terraform, Docker Compose и Google Cloud CLI.
- В директории, содержащей файлы terraform, инициализируются провайдеры и загружаются основные модули для создания инфраструктуры с помощью команды "terraform init".
- Осуществляется просмотр плана изменений, которые планируется применить Terraform к инфраструктуре с помощью команды "terraform plan".
- Применяются изменения, описанные в Terraform-конфигурации, к инфраструктуре Google Cloud Platform с помощью команды "terraform apply".
- Создается Docker-образ на основе указанного в Dockerfile файла.
- С помощью Docker Compose запускается контейнер из созданного образа.
- Производится проверка путем отправки HTTP-запросов к контейнеру Docker. Если возвращаемый HTTP-код равен 200, проверка считается успешной.
- Контейнер останавливается, а Docker-образ удаляется.
- Устанавливается Google Kubernetes Engine Authentication Plugin для работы с кластером Kubernetes GKE.
- Устанавливается набор библиотек Google Cloud SDK для взаимодействия с облачной платформой.
- Проверяется подключение к кластеру Google Kubernetes Engine.
- Выполняется предварительная проверка авторизации на Docker Hub для возможности загрузки образа в репозиторий.
- Создается Docker-образ на основе указанного в Dockerfile файла.
- Образ загружается в репозиторий Docker Hub.
- Приложение разворачивается на основе образа, расположенного в репозитории Docker Hub, с использованием yaml-файла.
- Отправляются уведомления в Telegram о публикации приложения.

### 3. Предварительные условия для реализации проекта:

3.1 Наличие действующего проекта Google Cloud Platform <br> <br>

3.2 В проекте должны быть включены следующие API провайдера: <br>
- Kubernetes Engine API
- Compute Engine API
- Cloud Build API
- Cloud Resource Manager API

3.3 Предварительно создан bucket для хранения файла состояния terraform <br> <br>

3.4 В проекте Google Cloud Platform создан service account с предварительно сгенерированным JSON–ключом и обладающим следующими привелегиями:
- Compute Storage Admin
- Kubernetes Engine Cluster Admin
- Kubernetes Engine Developer
- Storage Admin
- Storage Folder Admin
- Storage Object Admin

3.5 Созданный репозиторий в Docker Hub

3.6 Создание посредством BotFather бота для оповещений telegram

3.7 Наличие следующих секретов в GitHub:
- DOCKER_PASSWORD – токен доступа сгенерированный в Docker Hub
- DOCKER_USERNAME – имя учетной записи в Docker Hub
- GOOGLE_APPLICATION_CREDENTIALS – данне JSON-файла сервисного аккаунта Google Cloud Platform
- GOOGLE_CREDENTIALS – данне JSON-файла сервисного аккаунта Google Cloud Platform
- GOOGLE_PROJECT – ID проекта Google Cloud Platform
- TELEGRAM_CHAT_ID – ID группы Telegram
- TELEGRAM_TOKEN – токен созданный BotFather

### 4. Структура и описание шагов проекта:
Структура проекта:
```
DOS18-onl-diploma/
├── Docker
│   ├── docker-compose.yml
│   ├── Dockerfile
│   └── WebSite
│       ├── about.html
│       ├── images
│       │   ├── dec1.png
│       │   ├── dec2.png
│       │   ├── devops.png
│       │   ├── LateMouse.jpg
│       │   └── top.jpg
│       ├── index.html
│       └── project.html
├── k8s
│   └── diploma.yaml
├── Pre_deployment_checks.yaml
├── README.md
└── terraform
    ├── 0-variables.tf
    ├── 1-provider.tf
    ├── 2-vpc.tf
    ├── 3-subnets.tf
    ├── 4-router.tf
    ├── 5-nat.tf
    ├── 6-firewalls.tf
    ├── 7-kubernetes.tf
    └── 8-node-pools.tf

5 directories, 22 files
```

#### 4.1 Описание конфигурации Terraform
В рамках конфигурации Terraform используется восемь файлов, каждый из которых описывает отдельный элемент инфраструктуры. Ниже приведено описание файлов конфигурации: <br>

##### 4.1.1. Файл /terraform/0-variables.tf
В данном файле содержится конфигурация переменных, которые будут использоваться в проекте Terraform. Каждая переменная имеет свое описание и значение по умолчанию.
```tf
variable "project_id" {
  description = "ID проекта Google Cloud"
  default     = "latemouse"
}

variable "region" {
  description = "Регион Google Cloud"
  default     = "europe-west3"
}

variable "zone" {
  description = "Зона Google Cloud"
  default     = "europe-west3-b"
}

variable "machine_type" {
  description = "Тип разворачиваемых машин"
  default     = "e2-small"
}
```


##### 4.1.2. Файл /terraform/1-provider.tf
В данном файле "1-provider.tf" содержится конфигурация провайдера и настроек Terraform. Блок провайдера используется для взаимодействия с Google Cloud. Указываются настройки провайдера, такие как идентификатор проекта ("project_id"), регион ("region") и зона ("zone"). Значения для этих настроек берутся из переменных, определенных в файле "0-variables.tf". <br>
В блоке настроек Terraform указывается использование Google Cloud Storage в качестве удаленного хранилища состояния Terraform и указывается требуемый провайдер для данной конфигурации Terraform.
```tf
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

terraform {
  backend "gcs" {
    bucket = "latemouse-tf-state"
    prefix = "terraforn/state"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.27"
    }
  }
}
```

##### 4.1.3. Файл /terraform/2-vpc.tf
Общая цель данной конфигурации - создание виртуальной частной сети (VPC) в проекте Google Cloud с определенными параметрами и активацией необходимых служб. Конфигурация активирует службу Google Compute Engine в проекте, активирует службу Google Kubernetes Engine в проекте. Задаются параметры сети, такие как имя, режим маршрутизации, возможность автоматического создания подсетей, MTU (максимальный размер единицы передачи) и удаление маршрутов по умолчанию при создании сети. Указываются зависимости от других ресурсов: активации служб "compute.googleapis.com" и "container.googleapis.com". Это означает, что перед созданием сети будут активированы необходимые службы.
```tf
resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

resource "google_project_service" "container" {
  service = "container.googleapis.com"
}

resource "google_compute_network" "main" {
  name                            = "main"
  routing_mode                    = "REGIONAL"
  auto_create_subnetworks         = false
  mtu                             = 1460
  delete_default_routes_on_create = false

  depends_on = [
    google_project_service.compute,
    google_project_service.container
  ]
}
```

##### 4.1.4. Файл /terraform/3-subnets.tf
Общая цель данной конфигурации - создание подсети в Google Compute Engine с определенными параметрами, включая диапазон IP-адресов и дополнительные диапазоны IP-адресов для использования в Kubernetes-кластере. Создает подсеть в Google Compute Engine с именем "private" м задается диапазон IP-адресов подсети: "10.0.0.0/18". Указывается идентификатор сети, к которой принадлежит подсеть. Значение идентификатора сети берется из ресурса google_compute_network.main.id, определенного в файле "2-vpc.tf".
Указываются дополнительные диапазоны IP-адресов для размещения подов и размещения сервисов.
```tf
resource "google_compute_subnetwork" "private" {
  name                     = "private"
  ip_cidr_range            = "10.0.0.0/18"
  region                   = var.region
  network                  = google_compute_network.main.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "k8s-pod-range"
    ip_cidr_range = "10.48.0.0/14"
  }
  secondary_ip_range {
    range_name    = "k8s-service-range"
    ip_cidr_range = "10.52.0.0/20"
  }
}
```

##### 4.1.5. Файл /terraform/4-router.tf
Общая цель данной конфигурации - создание маршрутизатора в Google Compute Engine с определенными параметрами, включая имя маршрутизатора и принадлежность к определенной сети.
```tf
resource "google_compute_router" "router" {
  name    = "router"
  region  = var.region
  network = google_compute_network.main.id
}
```

##### 4.1.6. Файл /terraform/5-nat.tf
Общая цель данной конфигурации - настройка NAT для маршрутизатора в Google Compute Engine с определенными параметрами, включая имя настройки NAT, применение к подсетям, выделение IP-адресов и уровень сети для выделенного IP-адреса.
```tf
resource "google_compute_router_nat" "nat" {
  name   = "nat"
  router = google_compute_router.router.name
  region = var.region

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  nat_ip_allocate_option             = "MANUAL_ONLY"

  subnetwork {
    name                    = google_compute_subnetwork.private.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  nat_ips = [google_compute_address.nat.self_link]
}

resource "google_compute_address" "nat" {
  name         = "nat"
  address_type = "EXTERNAL"
  network_tier = "STANDARD"

  depends_on = [google_project_service.compute]
}
```

##### 4.1.7. Файл /terraform/6-firewalls.tf
Общая цель данной конфигурации - разрешить входящие SSH-соединения на порт 22 (SSH) в указанной сети в Google Compute Engine.
```tf
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

##### 4.1.8. Файл /terraform/7-kubernetes.tf
Цель данной конфигурации - настроить кластер Kubernetes с одним узлом, подключенным к указанным сети и подсети, и настроить его с учетом различных опций, таких как отключение дополнений, настройка идентификации нагрузки и приватного кластера.
```tf
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

  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = true
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "latemouse.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-range"
    services_secondary_range_name = "k8s-service-range"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }
}
```

##### 4.1.9. Файл /terraform/8-node-pools.tf
Цель данной конфигурации - настроить пулы узлов в кластере Kubernetes с различными параметрами, такими как тип машины, автоматическое восстановление и обновление, метки и сервисные аккаунты. <br>
Пул "general" – предназначен для общего использования и содержит один узел. Включено автоматическое восстановление и автоматическое обновление узла. <br>
Пул "spot" – предназначен для использования виртуальных машин. Использует автомасштабирование и может иметь от 0 до 10 узлов. Узлы помечены аннотацией "taint" с эффектом "NO_SCHEDULE", что означает, что поды не будут планироваться на эти узлы, если они не требуют явного использования таких узлов.  <br>
Оба пула узлов имеют разрешение на доступ к Google Cloud Platform через определенные oauth-области видимости.
```tf
resource "google_service_account" "kubernetes" {
  account_id = "kubernetes"
}

resource "google_container_node_pool" "general" {
  name       = "general"
  cluster    = google_container_cluster.primary.id
  node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
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

resource "google_container_node_pool" "spot" {
  name    = "spot"
  cluster = google_container_cluster.primary.id

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 0
    max_node_count = 10
  }

  node_config {
    preemptible  = true
    machine_type = var.machine_type

    labels = {
      team = "devops"
    }

    taint {
      key    = "instance_type"
      value  = "spot"
      effect = "NO_SCHEDULE"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
```

#### 4.2 Описание конфигурации Docker и Docker Compose
В директории "./Docker" содержатся конфигурационные файлы для сборки образа Docker и тестирования развертывания образа. Структура данной директории включает следующие директории и файлы:

##### 4.2.1. Директория /Docker/WebSite/*
В директории WebSite располагается набор html-страниц и изображений, предназначенных для публикации в Docker-образе с использованием веб-сервера Nginx. Этот образ будет дальше развертываться в облачной среде.
```
WebSite/
├── about.html
├── images
│   ├── dec1.png
│   ├── dec2.png
│   ├── devops.png
│   ├── LateMouse.jpg
│   └── top.jpg
├── index.html
└── project.html

1 directory, 8 files
```

##### 4.2.2. Файл /Docker/Dockerfile
Цель данного Dockerfile - создать образ, содержащий указанные html-страницы и изображения, которые будут доступны через веб-сервер Nginx. Этот образ может быть использован для развертывания веб-сайта или приложения, основанного на Nginx, в контейнерной среде.
```Dockerfile
FROM nginx:1.25.5

COPY WebSite/index.html /usr/share/nginx/html/index.html
COPY WebSite/about.html /usr/share/nginx/html/about.html
COPY WebSite/project.html /usr/share/nginx/html/project.html
COPY WebSite/images/LateMouse.jpg /usr/share/nginx/html/images/LateMouse.jpg
COPY WebSite/images/devops.png /usr/share/nginx/html/images/devops.png
COPY WebSite/images/dec1.png /usr/share/nginx/html/images/dec1.png
COPY WebSite/images/dec2.png /usr/share/nginx/html/images/dec2.png
COPY WebSite/images/dec3.png /usr/share/nginx/html/images/dec3.png
COPY WebSite/images/dec4.png /usr/share/nginx/html/images/dec4.png
COPY WebSite/images/top.jpg /usr/share/nginx/html/images/top.jpg
COPY WebSite/images/GKE.png /usr/share/nginx/html/images/GKE.png
COPY WebSite/images/tele1.png /usr/share/nginx/html/images/tele1.png
COPY WebSite/images/tele2.png /usr/share/nginx/html/images/tele2.png
COPY WebSite/images/web.jpg /usr/share/nginx/html/images/web.jpg
```

##### 4.2.2. Файл /Docker/docker-compose.yml
Цель данного docker-compose.yml - определить и настроить контейнер, созданный на основе образа "web", который предварительно собирается на GitHub Runner, чтобы он был доступен на порту 8080 хостовой машины.
```yaml
---
version: '3'
services:
  web:
    image: web
    ports:
      - 8080:80
```

#### 4.3 Описание конфигурации Kubernetes, diploma.yaml:
В директории "./k8s" содержится конфигурационный YAML файл для сборки приложения в среде Kubernetes. <br>
Цель данного файла "diploma.yaml" - описать и настроить ресурсы Kubernetes (Service и Deployment) для развертывания и управления приложением Nginx. Это позволяет автоматизировать масштабирование, управление и обеспечение доступности сервиса в Kubernetes-кластере. Основные аспекты кода: <br>
Описание ресурса "Service": <br>
- Используется API-версия "v1" для объекта "Service".
- Ресурс "Service" определяет набор правил доступа к сервису. В данном коде создается сервис с именем "nginx".
- Указывается тип сервиса "LoadBalancer", что позволяет использовать балансировщик нагрузки для распределения трафика на поды сервиса.
- Селектор "app: nginx" связывает сервис с подами, помеченными меткой "app: nginx".
- Порт 80 (хостовой порт) направляется на целевой порт 80 внутри подов.

Описание ресурса "Deployment": <br>
- Используется API-версия "apps/v1" для объекта "Deployment".
- Ресурс "Deployment" определяет спецификацию развертывания приложения. В данном коде создается развертывание с именем "nginx".
- Метки "app: nginx" связывают развертывание с сервисом и подами, относящимися к нему.
- Указывается желаемое количество реплик (подов) - 2.
- В шаблоне пода определяются контейнеры. В данном случае, используется контейнер с именем "nginx" и образом Docker Hub "dos18/diploma:latest".

```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: nginx
spec:
  type: LoadBalancer
  selector:
    app: nginx
  ports:
    - port: 80
      targetPort: 80

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: dos18/diploma:latest
```

### 5. Выполнение проекта:
Проект состоит из двух веток: main и dev. <br>
Ветка dev предназначена исключительно для проверки внесенных изменений и не влияет на активный проект. Ветка main имеет непосредственное влияние на активный процесс развертывания инфраструктуры в облачном провайдере и конфигурацию, а также на публикацию приложения в облаке. Запуск GitHub Actions происходит при коммите в основную ветку (main) или при слиянии (merge) dev ветки с основной. Все операции выполняются при помощи CI GitHub Actions на основе файла Deployment_Actions.yaml. <br>
Файл "Deployment_Actions.yaml" содержит описание действий для автоматического развертывания приложения. Ниже приведено общее описание кода:  <br>
- Настройка событий, на которые реагирует автоматизированный процесс развертывания. В данном случае процесс запускается при push в ветки "main" и "dev".
- Определение задачи "DeploymentActions", выполняющейся на операционной системе Ubuntu.
- Настройка параметров выполнения для задачи, включая использование оболочки bash.
- Определение последовательности шагов, которые нужно выполнить: <br>  <br>
        Проверка кода из репозитория Git. <br>
        Запуск проверки синтаксиса Terraform. <br>
        Запуск проверки синтаксиса файла Dockerfile. <br>
        Запуск проверки синтаксиса YAML-файлов Docker Compose. <br>
        Запуск проверки синтаксиса YAML-файлов Kubernetes. <br>
        Установка и настройка Terraform. <br>
        Установка и настройка Docker Compose. <br>
        Установка и настройка Google Cloud CLI. <br>
        Выполнение инициализации Terraform. <br>
        Выполнение планирования Terraform. <br>

- Применение изменений, если ветка - "main".
        Сборка Docker-образа. <br>
        Сборка и запуск Docker Compose. <br>
        Проверка доступности различных URL-адресов на локальном Docker-образе. <br>
        Остановка контейнеров и удаление Docker-образа. <br>
        Настройка аутентификации для использования Google Kubernetes Engine. <br>
        Установка Google Cloud SDK. <br>
        Подключение к кластеру Google Kubernetes Engine. <br>
        Аутентификация в Docker Hub. <br>
        Сборка и маркировка Docker-образа для репозитория Docker Hub. <br>
        Отправка Docker-образа в репозиторий Docker Hub. <br>
        Развертывание приложения на кластере Google Kubernetes Engine. <br>
        Уведомление в Telegram о развертывании приложения на ветке "main".  <br>

 <br>  <br>

Файл Deployment_Actions.yaml:
```yaml
name: Deployment actions

on:
  push:
    branches:
      - main
      - dev

jobs:
  DeploymentActions:
    runs-on: ubuntu-latest

    defaults:
      run:
        shell: bash

    steps:
      - name: "Git code checkout"
        uses: actions/checkout@v4

      - name: "Linter: Run Lint Terraform"
        uses: actionshub/terraform-lint@main

      - name: "Linter: Run Lint Dockerfile"
        uses: rusty-actions/dockerfile-linter@v1
        with:
          dockerfile: ./Docker/Dockerfile

      - name: "Linter: Run Lint Yaml file DockerCompose"
        uses: karancode/yamllint-github-action@master
        with:
          yamllint_file_or_dir: './Docker/'
          yamllint_strict: false
          yamllint_comment: true

      - name: "Linter: Run Lint Yaml file Kubernetes"
        uses: karancode/yamllint-github-action@master
        with:
          yamllint_file_or_dir: './k8s/'
          yamllint_strict: false
          yamllint_comment: true

      - name: "Install: Setting up Terraform"
        uses: hashicorp/setup-terraform@v3

      - name: "Install: Setting up Docker Compose"
        working-directory: ./Docker
        run: |
          sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
          sudo chmod +x /usr/local/bin/docker-compose
          sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
          sudo apt-get install docker-compose

      - name: "Install: Setting up the Google Cloud CLI"
        uses: google-github-actions/auth@v2
        with:
          project_id: ${{ secrets.GOOGLE_PROJECT }}
          credentials_json: ${{ secrets.GOOGLE_APPLICATION_CREDENTIALS }}

      - name: "Terraform: Runnig Terraform Init"
        working-directory: ./terraform
        run: |
          terraform init
        env:
          GOOGLE_CREDENTIALS: ${{ secrets.GOOGLE_CREDENTIALS }}

      - name: "Terraform: Runnig Terraform Plan"
        working-directory: ./terraform
        run: |
          terraform plan -input=false
        env:
          GOOGLE_CREDENTIALS: ${{ secrets.GOOGLE_CREDENTIALS }}

      - name: "Terraform: Runnig Terraform Apply"
        working-directory: ./terraform
        if: |
          github.ref == 'refs/heads/main'
        run: |
          terraform apply -auto-approve -input=false
        env:
          GOOGLE_CREDENTIALS: ${{ secrets.GOOGLE_CREDENTIALS }}

      - name: "Docker: Build Docker Image"
        working-directory: ./Docker
        run: |
          docker build -t web .

      - name: "Docker: Build and Run Docker Compose"
        working-directory: ./Docker
        run: |
          sudo docker-compose -f "docker-compose.yml" up -d --build

      - name: "Test: HTTP Request Verification from local Docker Image"
        run: |
          response=$(curl -s -o /dev/null -w "%{http_code}" 127.0.0.1:8080/index.html)
          if [ $response -eq 200 ]; then
            echo "Проверка доступности главной страницы: успешно"
          else
              echo "Проверка доступности главной страницы, ошибка. Код ответа: $response"
              exit 1
          fi
          response=$(curl -s -o /dev/null -w "%{http_code}" 127.0.0.1:8080/about.html)
          if [ $response -eq 200 ]; then
            echo "Проверка доступности страницы описания проекта: успешно"
          else
              echo "Проверка доступности страницы описания проекта, ошибка. Код ответа: $response"
              exit 1
          fi
          response=$(curl -s -o /dev/null -w "%{http_code}" 127.0.0.1:8080/project.html)
          if [ $response -eq 200 ]; then
            echo "Проверка доступности страницы работы с проектом: успешно"
          else
             echo "Проверка доступности страницы работы с проектом, ошибка. Код ответа: $response"
              exit 1
          fi
        
      - name: "Docker: Stop local Containers and Remove local Docker Image"
        working-directory: ./Docker
        run: |
          docker-compose -f "docker-compose.yml" down
          docker image rm web

      - name: "Install: Setting up the Google Kubernetes Engine Authentication Plugin"
        if: |
          github.ref == 'refs/heads/main'  
        uses: imjasonh/gke-auth@v0.1.0
        with:
          project: ${{ secrets.GOOGLE_PROJECT }}
          location: europe-west3-b
          cluster: primary

      - name: "Install: Setting up the Google Cloud SDK"
        if: |
          github.ref == 'refs/heads/main' 
        uses: 'google-github-actions/setup-gcloud@v2'
        with:
          install_components: 'gke-gcloud-auth-plugin'

      - name: "Test: Connect to Google Kubernetes Engine Cluster"
        if: |
          github.ref == 'refs/heads/main' 
        uses: google-github-actions/get-gke-credentials@v2
        with:
          cluster_name: primary
          location: europe-west3-b
          project_id: latemouse
          use_auth_provider: true
        env:
          GOOGLE_PROJECT: ${{ secrets.GOOGLE_PROJECT }}
          credentials_json: ${{ secrets.GOOGLE_APPLICATION_CREDENTIALS }}

      - name: "Test: Login to Docker Hub"
        uses: 'docker/login-action@v3'
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: "Docker: Build Docker Image for Docker Hub Repository"
        working-directory: ./Docker
        run: |
          docker build -t dos18/diploma .
          docker tag dos18/diploma dos18/diploma:latest
        env:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: "Docker: Push Docker Image to Docker Hub Repository"
        working-directory: ./Docker
        run: |
          docker login
          docker push dos18/diploma
        env:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: "Deploy: Deploy Application to Google Kubernetes Engine Cluster"
        working-directory: ./k8s
        if: |
          github.ref == 'refs/heads/main' 
        run: |
          gcloud container clusters get-credentials primary --zone europe-west3-b --project $GOOGLE_PROJECT
          kubectl apply -f diploma.yaml
        env:
         GOOGLE_PROJECT: ${{ secrets.GOOGLE_PROJECT }}
         credentials_json: ${{ secrets.GOOGLE_APPLICATION_CREDENTIALS }}
         username: ${{ secrets.DOCKER_USERNAME }}
         password: ${{ secrets.DOCKER_PASSWORD }}

      - name: "Notification: Telegram Notification from Dev Branch"
        uses: "appleboy/telegram-action@master"
        if: |
          github.ref == 'refs/heads/dev' 
        with:
          to: ${{ secrets.TELEGRAM_CHAT_ID }}
          token: ${{ secrets.TELEGRAM_TOKEN }}
          message: |
             ${{ github.actor }} created commit:
             Commit message: ${{ github.event.commits[0].message }}
             Repository: ${{ github.repository }}
             See changes: https://github.com/${{ github.repository }}/commit/${{github.sha}}

      - name: "Notification: Telegram Notification Deploying Application"
        uses: "appleboy/telegram-action@master"
        if: |
          github.ref == 'refs/heads/main'
        with:
          to: ${{ secrets.TELEGRAM_CHAT_ID }}
          token: ${{ secrets.TELEGRAM_TOKEN }}
          message: |
            ${{ github.actor }} created deploying application:
            Commit message: ${{ github.event.commits[0].message }}
            Repository: ${{ github.repository }}
            See changes: https://github.com/${{ github.repository }}/commit/${{github.sha}}
```


#### [Ветка dev]:
В процессе запуска ветки dev в рамках конвейера выполнены следующие этапы, специально предназначенные для данной ветки. Операции, связанные с изменением инфраструктуры, развертыванием кластера Kubernetes и публикацией приложения, не выполняются в данном контексте: <br> <br>

Выполнение pipeline при коммите в ветку dev: <br>
![изображение](https://github.com/LateMouse/DOS18-onl-diploma/assets/114028634/382bc699-4804-4523-830e-34e51c07c457) <br>
![изображение](https://github.com/LateMouse/DOS18-onl-diploma/assets/114028634/9ddfae28-06b4-48ef-99c2-02ce7c504997) <br> <br>

По результату выполнения отправляется уведомление в Telegram о внесении изменений в и ссылкой для просмотра изменений: <br>
![изображение](https://github.com/LateMouse/DOS18-onl-diploma/assets/114028634/fd57047c-6134-487e-94a2-fde1b0c26127) <br> <br>

#### [Ветка main]:
 В процессе запуска ветки main в рамках конвейера выполнены все этапы сборки, за исключением оповещения о изменении кода проекта, вместо этого отправляется уведомление о деплое проекта: <br> <br>


Выполнение pipeline при слиянии с веткой main: <br>
![изображение](https://github.com/LateMouse/DOS18-onl-diploma/assets/114028634/7d0a6b3b-865b-4347-bcdd-fdaf42ffc290) <br>
![изображение](https://github.com/LateMouse/DOS18-onl-diploma/assets/114028634/2784784c-891c-4ac6-9524-68fc66e2fb3e) <br>
![изображение](https://github.com/LateMouse/DOS18-onl-diploma/assets/114028634/5f6c2699-26f0-4cd2-9e23-384e87bbadd2) <br> <br>

По результату выполнения отправляется уведомление в Telegram о внесении изменений в и ссылкой для просмотра изменений: <br>
![изображение](https://github.com/LateMouse/DOS18-onl-diploma/assets/114028634/fefd63ef-c29f-4db2-a255-a64e8fcb9d3f) <br> <br>

#### Просмотр публикуемого приложения:
При завершении процесса pipeline в кластере GKE создастся сервис с "белым" ip-адресом публикуемого приложения.  <br>
![изображение](https://github.com/LateMouse/DOS18-onl-diploma/assets/114028634/2d208ac3-be8b-4257-8856-8327b94bed9c) <br> <br>

При переходе по ссылке откроется web страница выполненного проекта: <br>
![изображение](https://github.com/LateMouse/DOS18-onl-diploma/assets/114028634/b1522266-b0e0-41a4-912e-b8f7185c4069) <br> <br>

