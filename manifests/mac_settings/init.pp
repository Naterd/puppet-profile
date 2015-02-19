# == Class: profile::mac_settings::init
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
class profile::mac_settings{
  include profile::mac_settings::apple_setup_done
  include profile::mac_settings::disable_diagnostic_msg
}