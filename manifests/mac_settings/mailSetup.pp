class profile::mac_settings::mailSetup {
  $script = 'puppet:///modules/profile/mail-setup-ews/mailSetupEWS.py'

  file {"/usr/local/outset/login-every/mailSetupEWS.py":
    ensure  => present,
    source  => $script,
    owner   => root,
    group   => wheel,
    mode    => '0755',
    require => Class['outset'],
  }

  if ! defined(File['/usr/local/outset']) {
    file { '/usr/local/outset':
      ensure => "directory",
    }
  }

  if ! defined(File['/usr/local/outset/resources']) {
    file { '/usr/local/outset/resources':
      ensure => "directory",
    }
  }

  if ! defined(File['/usr/local/outset/resources/mail-setup']) {
    file { '/usr/local/outset/resources/mail-setup':
      ensure => "directory",
    }
  }  

  file { '/usr/local/outset/resources/mail-setup/templates':
    ensure  => "directory",
    content => 'puppet:///modules/profile/mail-setup-ews/templates',
    recurse => true,
    require => File['/usr/local/outset/resources/mail-setup'],
  }
}