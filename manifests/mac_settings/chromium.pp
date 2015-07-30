# Vendor made chromium a requirement for online testing and prefs needed
# changing to work properly.
class profile::mac_settings::chromium {
  $pref_path = '/Library/Application Support/Chromium/Default/Preferences'
  $pref = 'puppet:///modules/profile/ChromiumPref/Preferences'
  $chrome_dirs = [ "/Library/Application Support/Chromium", 
                    "/Library/Application Support/Chromium/Default", ]

  file {"${pref_path}":
    ensure => present,
    source  => $pref,
    owner   => root,
    group   => wheel,
    mode    => '0644',
    require => File[ $chrome_dirs ],
  }
  
  outset::login_once{'ChromiumPref.sh':
    script   => 'puppet:///modules/profile/ChromiumPref/ChromiumPref.sh',
    update   => true,
    priority => '7'
  }
  
  file { $chrome_dirs:
    ensure => "directory",
    owner  => "root",
    group  => "wheel",
    mode   => 664,
  }
}