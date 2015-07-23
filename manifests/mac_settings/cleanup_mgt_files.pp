# This class removes old management files prior to using puppet.
class profile::mac_settings::cleanup_mgt_files {
  file { "/usr/local/profiles":
    ensure => absent,
    force  => true,
  }
  
  file { "/usr/local/outset/login-once/bisd_audiovideo_desktop.sh":
    ensure => absent,
  }
  
  file { "/usr/local/outset/login-once/5-dock.sh":
    ensure => absent,
  }
}
