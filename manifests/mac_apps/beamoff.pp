# Install Beamoff from the internet
class profile::mac_apps::beamoff {
  $Agent = 'puppet:///modules/k12.bisd.launch_beamoff.plist'
  $min_os_version = '10.10'

  if $virtual == 'vmware' {
    if version_compare($::macosx_productversion_major, $min_os_version) < 0 {
      #notice('This operating system does not need Beamoff.')
    }
    else {
      package { 'Beamoff':
        source   => "http://cburlison.s3.amazonaws.com/public/beamoff.zip",
        provider => 'compressed_app',
      }
    
      file {"/Library/LaunchAgents/k12.bisd.launch_beamoff.plist":
        source  => $Agent,
        owner   => root,
        group   => wheel,
        mode    => '0664',
      }
    }
  }    
}