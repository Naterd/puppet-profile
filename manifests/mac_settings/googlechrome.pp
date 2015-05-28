class profile::mac_settings::googlechrome {
  $pref_path = '/Library/Application Support/Google/Chrome/Default/Preferences'
  $outset_path = '/usr/local/outset/login-'
  $pref = 'puppet:///modules/profile/ChromePref/Preferences'
  $script = 'puppet:///modules/profile/ChromePref/ChromePref.sh'

  file {"${pref_path}":
    ensure => present,
    source  => $pref,
    owner   => root,
    group   => wheel,
    mode    => '0644',
  }
  
  file {"${outset_path}every/7-ChromePref.sh":
    ensure => present,
    source  => $script,
    owner   => root,
    group   => wheel,
    mode    => '0755',
  }
}