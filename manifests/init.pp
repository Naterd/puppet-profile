# == Class: profile
#
# This is the basic setup for profiles at Birdville ISD.
#
# === Examples
#
# include profile
#
# === Authors
#
# Clayton Burlison <clayton.burlison@birdvilleschools.net>
#
# === Copyright
#
# Copyright 2015 Birdville ISD, unless otherwise noted.
#
class profile{
    class {'profile::wallpaper::default_wallpaper.pp': }
}