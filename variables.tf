variable "do_token" {
  type = string
}

variable "region" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "route53_zone_id" {
  type = string
}

variable "host" {
  type = string
}

variable "email" {
  type        = string
  description = "Used when requesting a Let's Encrypt certificate"
}

variable "ssh_public_key_file" {
  type        = string
  default     = "id_ghost.pub"
  description = "A path to an SSH public key file to use"
}
