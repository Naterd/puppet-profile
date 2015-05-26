class profile::mac_settings::dock {
  $script = hiera('outsetdock::script', 'puppet:///modules/profile/dockutil/district_dock.sh')
  $freq   = hiera('outsetdock::freq', 'once') 

  if $freq == 'once' {
    file {"/usr/local/outset/login-once/dock.sh":
      source  => $script,
      owner   => root,
      group   => wheel,
      mode    => '0755',
    }
  }

  if $freq == 'every' {
    file {"/usr/local/outset/login-every/dock.sh":
      source  => $script,
      owner   => root,
      group   => wheel,
      mode    => '0755',
    }
  }
}
