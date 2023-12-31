variable "name" {
  type        = string
  default     = "test"
  description = "Name of the resource. Provided by the client when the resource is created. "
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order, e.g. sequence of application name and environment `name`,`environment`,'attribute' [`webserver`,`qa`,`devops`,`public`,] ."
}

variable "managedby" {
  type        = string
  default     = ""
  description = "ManagedBy, eg 'cypik'."
}

variable "repository" {
  type        = string
  default     = "https://github.com/cypik/terraform-gcp-vm"
  description = "Terraform current module repo"
}

variable "image" {
  type        = string
  default     = "debian-cloud/debian-11"
  description = "Source image family. If neither source_image nor source_image_family is specified, defaults to the latest public CentOS image."
}

variable "machine_type" {
  type        = string
  default     = ""
  description = "Machine type to create, e.g. n1-standard-1"
}

variable "gcp_zone" {
  type        = string
  default     = ""
  description = "The GCP zone to create resources in"
}

variable "subnetwork" {
  type        = string
  default     = ""
  description = "Subnet to deploy to. Only one of network or subnetwork should be specified."
}

variable "instance_tags" {
  type        = list(string)
  default     = []
  description = "Network tags, provided as a list"
}

variable "metadata_startup_script" {
  type        = string
  default     = ""
  description = "User startup script to run when instances spin up"
}

variable "service_account_email" {
  type        = string
  default     = ""
  description = "The service account e-mail address. "
}

variable "service_account_scopes" {
  type        = list(string)
  default     = []
  description = "A list of service scopes."
}

variable "metadata" {
  type        = map(string)
  default     = {}
  description = "Metadata, provided as a map"
}

variable "allow_stopping_for_update" {
  type        = bool
  default     = true
  description = "must be set to true or your instance must have a desired_status of TERMINATED in order to update this field."
}

variable "enable_public_ip" {
  description = "Predefined enable_public_ip  address for the instance."
  type        = bool
  default     = false
}
