class profile::wallpaper::default_wallpaper.pp (
){

    outset::loginonce{'wallpaper':
        script => 'puppet:///modules/profile/wallpaper/bisd_default_desktop.sh'
    }

    if ! defined(File['/usr/local/outset/resources']) {
      file { '/usr/local/outset/resources':
        ensure => directory,
      }
    }

    if ! defined(File['/usr/local/outset/resources/set_desktops']) {
      file { '/usr/local/outset/resources/set_desktops':
        ensure => directory,
      }
    }
	
    file {'/usr/local/outset/resources/set_desktops/set_desktops.py':
        owner  => root,
        group  => wheel,
        mode   => '0755',
        source => 'puppet:///modules/profile/wallpaper/set_desktops.py',
    }
    
    file {'/usr/local/outset/resources/set_desktops/bisd_default.jpg':
        owner  => root,
        group  => wheel,
        mode   => '0755',
        source => 'puppet:///modules/profile/wallpaper/bisd_default.jpg',
    }
}
