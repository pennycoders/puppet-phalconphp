# Class: phalconphp::deps::jsonc
# Installs json-c (https://github.com/json-c/json-c)

class phalconphp::deps::jsonc (
  $debug = false) {
  include phalconphp::deps::sys

  exec { 'git-clone-json-c':
    command   => 'git clone https://github.com/json-c/json-c.git',
    cwd       => '/tmp',
    unless    => 'test -d /tmp/json-c',
    require   => [Class['phalconphp::deps::sys']],
    logoutput => $debug
  } ->
  exec { 'git-pull-json-c':
    command   => 'git pull',
    cwd       => '/tmp/json-c',
    onlyif    => 'test -d /tmp/json-c',
    require   => [Exec['git-clone-json-c']],
    logoutput => $debug,
    timeout   => 0
  } ->
  exec { 'autogen-json-c':
    command   => 'sh ./autogen.sh',
    cwd       => '/tmp/json-c',
    require   => [Exec['git-pull-json-c']],
    logoutput => $debug,
    timeout   => 0
  } ->
  exec { 'configure-json-c':
    command   => '/tmp/json-c/configure',
    cwd       => '/tmp/json-c',
    onlyif    => 'test -f /tmp/json-c/configure',
    require   => [Exec['autogen-json-c']],
    logoutput => $debug,
    timeout   => 0
  } ->
  exec { 'make-json-c':
    command   => "make -j${::processorcount}",
    cwd       => '/tmp/json-c',
    require   => [Exec['configure-json-c']],
    logoutput => $debug,
    timeout   => 0
  } ->
  exec { 'install-json-c':
    command   => "sudo make -j${::processorcount} install",
    cwd       => '/tmp/json-c',
    require   => [Exec['make-json-c']],
    logoutput => $debug,
    timeout   => 0
  } ->
  exec { 'remove-json-c-source':
    cwd       => '/tmp',
    command   => 'rm ./json-c -R -f',
    onlyif    => 'test -d /tmp/json-c',
    require   => [Exec['install-json-c']],
    logoutput => $debug,
    timeout   => 0
  }
}
