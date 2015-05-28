class profile::mac_settings::dock {
  $script      = hiera('outsetdock::script', 'puppet:///modules/profile/dockutil/district_dock.sh')
  $freq        = hiera('outsetdock::freq', 'once') 
  $ensure      = hiera('outsetdock::ensure', 'present')
  $script_name = hiera('outsetdock::script', '5-dock.sh')
  $outset_path = '/usr/local/outset/login-'
  $dockutil = 'puppet:///modules/profile/dockutil/dockutil'

  if $ensure == 'present' {
    file {"${outset_path}${freq}/${script_name}":
      ensure => present,
      source  => $script,
      owner   => root,
      group   => wheel,
      mode    => '0755',
      notify => Exec["remove_dock_once"],
    }
  }
  
  if $ensure == 'absent' {
    file {"${outset_path}${freq}/${script_name}":
      ensure => absent,
    }
  }
  
  exec { 'remove_dock_once':
    command     => "/etc/puppet/environments/production/modules/profile/files/dockutil/remove_dock_once.sh ${script_name}",
    refreshonly => true,
    subscribe   => File["${outset_path}${freq}/${script_name}"],
  }
  
  if $ensure != 'present' and $ensure !='absent'{
      fail('Invalid value for ensure.')
  }

  file {'/usr/local/bin/dockutil':
    owner  => root,
    group  => admin,
    mode   => '0755',
    source  => $dockutil,
    ensure => 'present',
  }
}