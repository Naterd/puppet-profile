# A hack to get around the fact that pluginsync doesn't work properly
# when using 'puppet apply'
# Will recursively sync the plugins folder to the right directory.
class profile::puppet::pluginsync (
  $libdir = "/var/lib/puppet/lib",
) {
  file {"$libdir":
    source  => "puppet:///plugins",
    recurse => true,
    purge   => true,
    force   => true,
  }
}
