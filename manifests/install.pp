class mysqlproxy::install inherits mysqlprox {

  if $install_url =~ /http/ {

    include staging
    staging::file { 'mysql-proxy.deb':
      source => $intsall_url,
    }

    package { 'mysql-proxy':
      ensure   => installed,
      provider => dpkg,
      source   => '/opt/staging/mysqlproxy/mysql-proxy.deb',
      require  => Staging::File['mysql-proxy.deb'],
    }

  } else {
    package{ 'mysql-proxy':
      ensure => installed;
    }
  }

  file { '/etc/mysql-proxy':
    owner   => root,
    group   => root,
    mode    => '0755',
    ensure  => directory,
    require => Package['mysql-proxy'],
  }

  file { '/etc/mysql-proxy/lua.d':
    owner   => root,
    group   => root,
    mode    => 0644,
    recurse => true,
    purge   => true,
    source  => 'puppet:///modules/mysqlproxy/lua.d',
    ensure  => directory;
  }

  #  unless ($luascript =='') {
  #    file{ "/etc/mysql-proxy/lua.d/${luascript}":
  #      owner   => root,
  #      group   => root,
  #      mode    => 644,
  #      source  => "puppet:///modules/mysqlproxy/lua.d/${luascript}",
  #      require => File['/etc/mysql-proxy/lua.d'],
  #    }
  #  }
}
