class mysqlproxy::install inherits mysqlproxy {

  if $install_url =~ /http/ {

    include staging

    staging::file { 'mysql-proxy.tar.gz':
      source => $install_url,
    } ->

    staging::extract { 'mysql-proxy.tar.gz':
      target  => '/opt/mysql-proxy',
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
    mode    => '0644',
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
