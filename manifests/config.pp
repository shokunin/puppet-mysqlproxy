class mysqlproxy::config inherits mysqlproxy {
  file { '/etc/default/mysql-proxy':
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template("mysqlproxy/default.erb");
  }
}
