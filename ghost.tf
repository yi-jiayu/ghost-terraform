resource "digitalocean_floating_ip" "ghost" {
  region = var.region
}

resource "aws_route53_record" "ghost" {
  zone_id = var.route53_zone_id
  name    = var.host
  type    = "A"
  ttl     = 300
  records = [digitalocean_floating_ip.ghost.ip_address]
}

resource "digitalocean_ssh_key" "ghost" {
  name       = "id_ghost"
  public_key = file(var.ssh_public_key_file)
}

resource "digitalocean_droplet" "ghost" {
  image      = "ubuntu-18-04-x64"
  name       = "ghost"
  region     = var.region
  size       = "s-1vcpu-1gb"
  monitoring = true
  ssh_keys   = [digitalocean_ssh_key.ghost.fingerprint]
  user_data = templatefile("cloud-init.yaml", {
    ssh_public_key : digitalocean_ssh_key.ghost.public_key,
    host : var.host,
    email : var.email,
  })
}

resource "digitalocean_floating_ip_assignment" "ghost" {
  ip_address = digitalocean_floating_ip.ghost.ip_address
  droplet_id = digitalocean_droplet.ghost.id
}
