# == Class: profile::puppet::init
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
class profile::puppet{
  include profile::puppet::pluginsync
  include profile::puppet::clean_reports
}