locals {  
   owner = var.bussiness_devisson
   envirornment = var.env-var

  gujjar_tag ={
    owner = local.owner
    envirornment =local.envirornment
  }

  resource_name_prefix = "${var.bussiness_devisson}-${var.env-var}"
}