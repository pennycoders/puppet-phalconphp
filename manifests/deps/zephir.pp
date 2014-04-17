# Class: phalconphp::deps::zephir
# Installs Zephir (http://zephir-lang.com/)
class phalconphp::deps::zephir (
  $debug   = false,
  $tmp_dir = '/tmp/zephir') {
  class { 'phalconphp::deps::jsonc': debug => $debug }

  vcsrepo { "zephir":
    ensure   => latest,
    path     => $tmp_dir,
    provider => git,
    require  => [Class['phalconphp::deps::jsonc']],
    source   => 'https://github.com/phalcon/zephir.git',
    revision => 'master'
  }

  file { "create-sudoers-file":
    path    => "/etc/sudoers.d/0-phalconphp",
    ensure  => file,
    content => "Default:root !requiretty",
    owner   => "root"
  }

  exec { 'install-zephir':
    command   => './install -c',
    cwd       => $tmp_dir,
    require   => [
      File["create-sudoers-file"],
      Vcsrepo['zephir']],
    logoutput => $debug,
    path      => [
      '/bin',
      '/usr/local/bin',
      '/usr/bin',
      '/sbin',
      '/usr/sbin'],
    timeout   => 0
  }

  file { "remove-sudoers-file":
    path    => "/etc/sudoers.d/0-phalconphp",
    ensure  => absent,
    require => [Exec["install-zephir"]]
  }

  exec { 'check-zephir':
    command   => 'zephir version',
    logoutput => $debug,
    path      => [
      '/bin',
      '/usr/local/bin',
      '/usr/bin',
      '/sbin',
      '/usr/sbin'],
    require   => [Exec['install-zephir']],
    timeout   => 0
  }
}
