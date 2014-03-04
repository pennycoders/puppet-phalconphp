# Class: phalconphp::deps::zephir
# Installs Zephir (http://zephir-lang.com/)
class phalconphp::deps::zephir (
  $debug = false) {
  class { 'phalconphp::deps::jsonc': debug => $debug }

  exec { 'git-clone-zephir':
    command   => 'git clone https://github.com/phalcon/zephir.git',
    cwd       => '/tmp',
    unless    => 'test -d /tmp/zephir',
    require   => [Class['phalconphp::deps::sys']],
    logoutput => $debug
  } ->
  exec { 'git-pull-zephir':
    command   => 'git pull',
    cwd       => '/tmp/zephir',
    onlyif    => 'test -d /tmp/zephir',
    logoutput => $debug
  } ->
  exec { 'install-zephir':
    command   => './install -c',
    cwd       => '/tmp/zephir',
    require   => [Class['phalconphp::deps::jsonc']],
    logoutput => $debug
  } ->
  exec { 'check-zephir':
    command   => 'zephir version',
    logoutput => $debug,
    require   => [Exec['install-zephir']]
  }
}
