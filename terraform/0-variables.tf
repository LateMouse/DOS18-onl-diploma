## В этом блоке определяются переменные, которые будут использоваться в конфигурации Terraform. 

variable "project_id" {
  description = "ID проекта Google Cloud"
  default     = "dos18-onl-dip"
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


