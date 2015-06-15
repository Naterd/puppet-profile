class profile::mac_settings::finder_prefs {
  $script      = 'puppet:///modules/profile/finder_prefs/finder_prefs.sh'
  $freq        = 'once'
  $ensure      = 'present'
  $script_name = '1-finder_prefs.sh'
  $outset_path = '/usr/local/outset/login-'
  
  if $ensure == 'present' {
    file {"${outset_path}${freq}/${script_name}":
      ensure => present,
      source  => $script,
      owner   => root,
      group   => wheel,
      mode    => '0755',
    }
  }
  
  if $ensure == 'absent' {
    file {"${outset_path}${freq}/${script_name}":
      ensure => absent,
    }
  }
  
  if $ensure != 'present' and $ensure !='absent'{
      fail('Invalid value for ensure.')
  }
}