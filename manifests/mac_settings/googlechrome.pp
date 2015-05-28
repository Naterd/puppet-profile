class profile::mac_settings::googlechrome {
  $pref_path = '/Library/Application Support/Google/Chrome/Default/Preferences'
  $outset_path = '/usr/local/outset/login-'
  $pref = 'puppet:///modules/profile/ChromePref/Preferences'
  $script = 'puppet:///modules/profile/ChromePref/ChromePref.sh'
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
  
  file {"${outset_path}every/7-ChromePref.sh":
    ensure => present,
    source  => $script,
    owner   => root,
    group   => wheel,
    mode    => '0755',
  }

  file { $chrome_dirs:
      ensure => "directory",
      owner  => "root",
      group  => "wheel",
      mode   => 664,
  }
}