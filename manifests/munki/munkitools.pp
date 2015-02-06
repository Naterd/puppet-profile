class profile::munki::munkitools {
  exec {"/sbin/reboot":
    refreshonly => true,
  }

  package { 'munkitools-2.2.0.2399.pkg' :
    provider => pkgdmg,
    alias    => 'munkitools',
    ensure   => installed,
    source   => 'https://github.com/munki/munki/releases/download/v2.2.0.2399/munkitools-2.2.0.2399.pkg',
    notify   => Exec["/sbin/reboot"],
  }
}