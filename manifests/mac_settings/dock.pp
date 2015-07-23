class profile::mac_settings::dock {
  include profile::utils::dockutil
  
  outset::login_once{'district_dock.sh':
    script   => hiera('outsetdock::script', 'puppet:///modules/profile/dockutil/district_dock.sh'),
    update   => true,
    priority => '5'
  }
}