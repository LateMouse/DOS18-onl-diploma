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
│       │   ├── devops.jpg
│       │   └── LateMouse.jpg
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
