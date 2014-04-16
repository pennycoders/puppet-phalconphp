# Class: phalconphp::deps::zephir
# Installs Zephir (http://zephir-lang.com/)
class phalconphp::deps::zephir (
  $debug       = false,
  $install_dir = '/usr/share/php/zephir') {
  class { 'phalconphp::deps::jsonc': debug => $debug }

  vcsrepo { "zephir":
    ensure   => latest,
    path     => $installdir,
    provider => git,
    require  => [Class['phalconphp::deps::jsonc']],
    source   => 'https://github.com/phalcon/zephir.git',
    revision => 'master'
  }

  exec { 'install-zephir':
    command   => './install',
    cwd       => $install_dir,
    require   => [Vcsrepo['zephir']],
    logoutput => $debug,
    path      => [
      '/bin',
      '/usr/local/bin',
      '/usr/bin',
      '/sbin',
      '/usr/sbin'],
    timeout   => 0
  }

  file { 'zephir-bin':
    ensure  => link,
    path    => '/usr/bin/zephir',
    target  => "${installdir}/bin/zephir",
    require => [Exec['install-zephir']]
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
    require   => [File['zephir-bin']],
    timeout   => 0
  }