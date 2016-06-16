class mysqlproxy::service {

  include stdlib

  notify { "TEST: ${::os['release']['major']}": }
  #if versioncmp($::os['release']['major'], '14.04') > 0 {
  #  notify { 'Setup using systemd': }
  #} else {
  #  notify { 'Setup using upstart': }
  #}

  service { 'mysql-proxy':
    ensure    => running,
    hasstatus => true,
  }

}
