class mysqlproxy::install inherits mysqlproxy {

  if $install_version =~ /mysql-proxy/ {

    include staging

    file { '/opt/mysql-proxy':
      ensure => directory,
      owner  => root,
      group  => root,
      mode   => '0755',
    } ->
    staging::file { 'mysql-proxy.tar.gz':
      source => "https://downloads.mysql.com/archives/get/file/${install_version}.tar.gz",
    } ->
    staging::extract { 'mysql-proxy.tar.gz':
      target  => '/opt/mysql-proxy',
    } ->
    file { '/usr/bin/mysql-proxy' :
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => '0755',
      content => "#!/bin/bash\n/opt/mysql-proxy/${install_version}/bin/mysql-proxy",
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
