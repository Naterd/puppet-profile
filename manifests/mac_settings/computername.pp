# This class will verify that the computer name and asset tag are set properly.
# The csv file has data based off the serial number.
class profile::mac_settings::computername {
  
  $checkscript = '/etc/puppet/environments/production/modules/profile/files/name_mac/installcheck_script.py'
  $postscript = '/etc/puppet/environments/production/modules/profile/files/name_mac/postinstall_script.py'
  $csv = '/etc/puppet/environments/production/modules/profile/files/name_mac/names.csv'
  
  exec { "set_compname":
      command => $postscript,
      onlyif  => $checkscript,
      require => File["/usr/local/name_mac/names.csv"],
  }
  
  if ! defined(File['/usr/local']) {
    file { '/usr/local':
      ensure => directory,
    }
  }

  if ! defined(File['/usr/local/name_mac']) {
    file { '/usr/local/name_mac':
      ensure => directory,
    }
  }

  file {"/usr/local/name_mac/names.csv":
    ensure => present,
    source  => $csv,
    owner   => root,
    group   => wheel,
    mode    => '0600',
  }
}
