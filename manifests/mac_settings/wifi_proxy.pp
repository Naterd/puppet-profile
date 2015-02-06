# Configures the proxy settings to point to a pac file.
#
class profile::mac_settings::wifi_proxy (
  $autoproxyurl = 'http://localhost/proxy.pac'
) {
  exec {'autoproxyurl':
    command => "/usr/sbin/networksetup -setautoproxyurl wi-fi $autoproxyurl",
  }
  exec {'autoproxy':
    command => '/usr/sbin/networksetup -setproxyautodiscovery wi-fi on',
    unless  => '/usr/sbin/networksetup -getproxyautodiscovery wi-fi | grep "Discovery: On"',
  }
  exec {'autoproxystate':
    command => '/usr/sbin/networksetup -setautoproxystate wi-fi on',
  }
}

