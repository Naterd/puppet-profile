class profile{
  if $::osfamily == 'Darwin' {
      include profile::mac_base
  }
  else {
    fail("unsupported osfamily: ${::osfamily}")
  }
}