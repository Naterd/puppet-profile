class profile::utils::dockutil {
  include profile::mac_settings::dock
  $dockutil = 'puppet:///modules/profile/dockutil/dockutil'

  file {'/usr/local/bin/dockutil':
    owner  => root,
    group  => admin,
    mode   => '0755',
    source  => $dockutil,
    ensure => 'present',
  }
}
