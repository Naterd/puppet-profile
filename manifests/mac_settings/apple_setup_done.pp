class profile::mac_settings::apple_setup_done {

  file {'/private/var/db/.AppleSetupDone':
    owner  => root,
    group  => wheel,
    mode   => '0644',
    ensure => 'present'
  }
  
  file {'/Library/Receipts/.SetupRegComplete':
    owner  => root,
    group  => wheel,
    mode   => '0644',
    ensure => 'present'
  }
}
