class profile::mac_settings::finder_prefs {
  outset::login_once{'finder_prefs.sh':
    script   => 'puppet:///modules/profile/finder_prefs/finder_prefs.sh',
    priority => '1',
    update   => true,
  }
  
  outset::login_once{'FavoriteServers.py':
    script   => 'puppet:///modules/profile/finder_prefs/FavoriteServers.py',
    priority => '8',
    update   => false,
  }
}