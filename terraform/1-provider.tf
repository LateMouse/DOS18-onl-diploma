## Определен провайдер "google", который используется для взаимодействия с Google Cloud. 
## Указываются настройки провайдера, такие как идентификатор проекта ("project_id"), регион ("region") и зона ("zone"). 
# Значения для этих настроек берутся из переменных, определенных в файле 0-variables.tf
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

## В этом блоке определены настройки Terraform. 
## В блоке "backend" указывается использование Google Cloud Storage в качестве удаленного хранилища состояния Terraform. 
## Задается имя bucket и префикс для состояния Terraform. 
## В блоке "required_providers" указывается требуемый провайдер для этой конфигурации Terraform.
## В данном случае, это провайдер "google" от HashiCorp с версией, указанной как "~> 5.27". 
terraform {
  backend "gcs" {
    bucket = "dos18-onl-tf-state-staging"
    prefix = "terraforn/state"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.27"
    }
  }
}

