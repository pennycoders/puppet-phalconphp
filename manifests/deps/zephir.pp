# Class: phalconphp::deps::zephir
# Installs Zephir (http://zephir-lang.com/)
class phalconphp::deps::zephir {
  include phalconphp::deps::jsonc

  exec { 'git-clone-zephir':
    command   => 'git clone https://github.com/phalcon/zephir.git',
    cwd       => '/tmp',
    unless    => 'test -d /tmp/zephir',
    logoutput => true,
  } ->
  exec { 'git-pull-zephir':
    command   => 'git pull',
    cwd       => '/tmp/zephir',
    onlyif    => 'test -d /tmp/zephir',
    logoutput => true,
  } ->
  exec { 'install-zephir':
    command   => './install -c',
    cwd       => '/tmp/zephir',
    require   => [Class['phalconphp::deps::jsonc']],
    logoutput => true,
  } ->
  exec { 'check-zephir':
    command   => 'zephir version',
    logoutput => true,
    require   => [Exec['install-zephir']]
  }
}
