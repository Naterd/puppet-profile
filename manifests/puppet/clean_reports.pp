class profile::puppet::clean_reports {
  tidy { "/var/lib/puppet/reports":
    age => "3d",
    recurse => true,
  }
}