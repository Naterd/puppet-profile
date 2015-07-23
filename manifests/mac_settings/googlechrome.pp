class profile::mac_settings::googlechrome {
  $pref_path = '/Library/Application Support/Google/Chrome/Default/Preferences'
  $pref = 'puppet:///modules/profile/ChromePref/Preferences'
  $chrome_dirs = [ "/Library/Application Support/Google", "/Library/Application Support/Google/Chrome",
                    "/Library/Application Support/Google/Chrome/Default", ]

  file {"${pref_path}":
    ensure => present,
    source  => $pref,
    owner   => root,
    group   => wheel,
    mode    => '0644',
    require => File[ $chrome_dirs ],
  }
  
  outset::login_every{'ChromePref.sh':
    script   => 'puppet:///modules/profile/ChromePref/ChromePref.sh',
    priority => '7'
  }
  
  file { $chrome_dirs:
    ensure => "directory",
    owner  => "root",
    group  => "wheel",
    mode   => 664,
  }
}