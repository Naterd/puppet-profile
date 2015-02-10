# == Class: profile::munki::munkitools
#
# Installs Munki and optionally sets Munki into Bootstrap mode
#
# === Parameters
#
# [*bootstrap*]
#   Touch /Users/Shared/.com.googlecode.munki.checkandinstallatstartup when the Munki package is changed. Defaults to true.
#
# === Examples
#
#  class { 'mac_admin::munki':
#    bootstrap => true,
#  }
#
class profile::munki::munkitools(
  $bootstrap = true,
){
  
  ## Restart after munki install
  exec {"/sbin/reboot":
    refreshonly => true,
  }

  ## Install the latest Munki
  package { 'munki_tools2' :
    provider => pkgdmg,
    alias    => 'munkitools',
    ensure   => installed,
    source   => 'https://github.com/munki/munki/releases/download/v2.2.0.2399/munkitools-2.2.0.2399.pkg',
  #  notify   => Exec["/sbin/reboot"],
  }
  
  ## If we need to, touch the bootstrap file
  if ($bootstrap==true){
      exec {'munki-check':
        command     => '/usr/bin/touch /Users/Shared/.com.googlecode.munki.checkandinstallatstartup',
        refreshonly => true,
        subscribe   => Package['munki_tools2'],
      }
  }
}