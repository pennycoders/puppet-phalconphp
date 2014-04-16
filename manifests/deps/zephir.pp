# Class: phalconphp::deps::zephir
# Installs Zephir (http://zephir-lang.com/)
class phalconphp::deps::zephir (
  $debug = false) {
  class { 'phalconphp::deps::jsonc': debug => $debug }

  vcsrepo { "zephir":
    ensure   => latest,
    path     => '/tmp/zephir',
    provider => git,
    require  => [Class['phalconphp::deps::jsonc']],
    source   => 'https://github.com/phalcon/zephir.git',
    revision => 'master'
  }

  exec { 'install-zephir':
    command   => './install -c',
    cwd       => '/tmp/zephir',
    require   => [Vcsrepo['zephir']],
    logoutput => $debug,
    timeout   => 0
  }

  exec { 'check-zephir':
    command   => 'zephir version',
    logoutput => $debug,
    require   => [Exec['install-zephir']],
    timeout   => 0
  }
}
