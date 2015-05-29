class profile::mac_settings::adobe_eula {
  $AcrobatPro = 'puppet:///modules/profile/DiagnosticMessages/DiagnosticMessagesHistory.plist'
  $AcrobatReader = 'puppet:///modules/profile/DiagnosticMessages/DiagnosticMessagesHistory.plist'
  $script = 'puppet:///modules/profile/DiagnosticMessages/DiagnosticMessagesHistory.plist'

  require outset

  file {"/usr/local/outset/login-once/AdobeAcceptEULA.sh":
    source  => $script,
    owner   => root,
    group   => wheel,
    mode    => '0755',
  }
  
  file {"/usr/local/outset/resources/AcceptAdobeEULA/com.adobe.Acrobat.Pro.plist":
    source  => $AcrobatPro,
    owner   => root,
    group   => wheel,
    mode    => '0755',
    require => File['/usr/local/outset/resources/AcceptAdobeEULA'],
  }
  
  file {"/usr/local/outset/resources/AcceptAdobeEULA/com.adobe.Reader.plist":
    source  => $AcrobatReader,
    owner   => root,
    group   => wheel,
    mode    => '0755',
    require => File['/usr/local/outset/resources/AcceptAdobeEULA'],
  }
  
  if ! defined(File['/usr/local/outset/resources']) {
    file { '/usr/local/outset/resources':
      ensure => directory,
    }
  }
  
  if ! defined(File['/usr/local/outset/resources/AcceptAdobeEULA']) {
    file { '/usr/local/outset/resources/AcceptAdobeEULA':
      ensure => directory,
    }
  }
}
