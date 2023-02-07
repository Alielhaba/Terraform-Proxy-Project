variable "alb-name" {
  
}

variable "AZ" {

}

variable "SG-ELB" {
  
}

variable "instances-id" {

}

variable "check-cross-zone-load-balancing" {
  type = bool
  default = true
}

variable "check-connection-draining" {
  type = bool
  default = true
}