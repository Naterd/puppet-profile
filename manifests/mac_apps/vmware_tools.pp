# Install VMware Tools from the internet
class profile::mac_apps::vmware_tools {
  
  if $virtual == 'vmware' {
    package { 'vmwaretools':
      source   => "https://www.dropbox.com/s/64z7v8nzbhaw31a/VMwareTools.dmg?raw=1",
      provider => 'pkgdmg',
    }
  }
}