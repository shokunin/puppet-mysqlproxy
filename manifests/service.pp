class mysqlproxy::service inherits mysqlproxy {

  include stdlib

  file { '/lib/systemd/system/mysql-proxy.service':
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/mysqlproxy/mysql-proxy.service',
  }

  service { 'mysql-proxy':
    ensure    => running,
    hasstatus => true,
    require   => File['/lib/systemd/system/mysql-proxy.service'],
  }

}
