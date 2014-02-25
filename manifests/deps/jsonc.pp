# Class: phalconphp::deps::jsonc
# Installs json-c (https://github.com/json-c/json-c)

class phalconphp::deps::jsonc {
  include phalconphp::deps::sys
  include phalconphp::deps::git

  exec { 'git-clone-json-c':
    command   => 'git clone https://github.com/json-c/json-c.git',
    cwd       => '/tmp',
    unless    => 'test -d /tmp/json-c',
    logoutput => true,
    require   => [Package['git']]
  } ->
  exec { 'git-pull-json-c':
    command   => 'git pull',
    cwd       => '/tmp/json-c',
    onlyif    => 'test -d /tmp/json-c',
    require   => [Exec['git-clone-json-c']],
    logoutput => true
  } ->
  exec { 'autogen-json-c':
    command   => 'sh ./autogen.sh',
    cwd       => '/tmp/json-c',
    logoutput => true,
    require   => [Exec['git-pull-json-c']],
  } ->
  exec { 'configure-json-c':
    command   => '/tmp/json-c/configure',
    cwd       => '/tmp/json-c',
    onlyif    => 'test -f /tmp/json-c/configure',
    require   => [Exec['autogen-json-c']],
    logoutput => true
  } ->
  exec { 'make-json-c':
    command   => "make -j${::processorcount}",
    cwd       => '/tmp/json-c',
    require   => [Exec['configure-json-c']],
    logoutput => true
  } ->
  exec { 'install-json-c':
    command   => "sudo make -j${::processorcount} install",
    cwd       => '/tmp/json-c',
    logoutput => true,
    require   => [Exec['make-json-c']]
  } ->
  exec { 'remove-json-c-source':
    cwd     => '/tmp',
    command => 'rm ./json-c -R -f',
    onlyif  => 'test -d /tmp/json-c',
    require => [Exec['install-json-c']]
  }
}
