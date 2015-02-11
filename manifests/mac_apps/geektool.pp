# Install GeekTool from the internet
class profile::mac_apps::geektool {

  package { 'Geektool':
    source   => "http://download.tynsoe.org/GeekTool-3.1.1-311.zip",
    provider => 'compressed_app',
  }
}