provider "kubernetes" {
  config_path = "~/.kube/config"
}

/* terraform {
  backend "kubernetes" {
    secret_suffix = "roberto"
    namespace = "roberto"
  }
} */
module "apache" {
  source = "./modules/apache2/"
}
module "mysql" {
  source = "./modules/mysql/"
}
module "php" {
  source = "./modules/phpmyadmin/"
}
/* module "persistentvolume" {
  source = "./modules/persistentvolumes"
}
module "persistentvolumeclaim" {
  source = "./modules/persistentvolumeclaim"
} */
