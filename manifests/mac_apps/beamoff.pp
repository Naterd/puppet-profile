# Install Beamoff from the internet
class profile::mac_apps::beamoff {
  $Agent = 'puppet:///modules/k12.bisd.launch_beamoff.plist'

  if $virtual == 'vmware' {
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