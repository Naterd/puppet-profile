# Turns IPv6 WiFi settings off.
class profile::mac_settings::ipv6off (
) {
  exec {"ipv6off_wifi":
    command => "/usr/sbin/networksetup -setv6off Wi-Fi",
    unless  => "/usr/sbin/networksetup -getinfo Wi-Fi | grep 'IPv6: Off'"
  }
}

