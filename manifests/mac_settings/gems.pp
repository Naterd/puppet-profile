class profile::mac_settings::gems {
	
	package { 'hiera-eyaml':
		provider => 'gem',
		ensure   => 'latest',
	}
	
}