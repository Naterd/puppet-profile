class profile::mac_settings::mouseRightClick {
  outset::login_once{'mouseRightClick.sh':
    script   => 'puppet:///modules/profile/mouseRightClick/mouseRightClick.sh',
    priority => '3',
    update   => true,
  }
}