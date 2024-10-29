# virtual-network ip addr
variable "virtual-net" {
  type = string
  default = "Virtual-Net"   # no need or noo value of this in front of .tfvars files values define variables
}
variable "virtual_net-ip-addr" {
  type = list(string)
  default = [ "172.16.0.0/16" ]       # no need or noo value of this in front of .tfvars files values define variables
}

#Web sunet
variable "web_sub_name" {
  type = string
  default = "Web_subnet"          # no need or noo value of this in front of .tfvars files values define variables
}
variable "web_subnet-ip-addr" {
  type = list(string)
  default = [ "172.16.2.0/24" ]         # no need or noo value of this in front of .tfvars files values define variables
}

#app subnet
variable "app_subnet-name" {
  type = string
  # default = "App_subnet"           # no need or noo value of this in front of .tfvars files values define variables
}
variable "app_subnet-addr" {
  type = list(string)
  default = [ "172.16.3.0/24" ]        # no need or noo value of this in front of .tfvars files values define variables
}

#DB subnet
variable "db_subnet-name" {
  type = string
  # default = "DB_sunet"
}
variable "db_subnet-ip-addr" {
  type = list(string)
  default = [ "172.16.5.0/24" ]
}

# Bestion subnet
variable "bestion_subnet-name" {
  type = string
  default = "Bestion-subnet"
}
variable "bestion_subnet-ip-addr" {
  type = list(string)
  default = [ "172.16.8.0/24" ]
}