# == Class: profile::mac_apps::init
#
#
#
# === Authors
#
# Clayton Burlison <clburlison@gmail.com>
#
# === Copyright
#
# Copyright 2015 Clayton Burlison, unless otherwise noted.
class profile::mac_apps{
  include profile::mac_apps::geektool
  include profile::mac_apps::vmware_tools
}