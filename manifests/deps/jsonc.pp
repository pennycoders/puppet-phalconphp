# Class: phalconphp::deps::jsonc
# Installs json-c (https://github.com/json-c/json-c)

class phalconphp::deps::jsonc (
  $debug = false) {
  include phalconphp::deps::sys

  vcsrepo { "json-c":
    ensure   => latest,
    path     => '/tmp/json-c',
    provider => git,
    source   => 'https://github.com/json-c/json-c.git',
    revision => 'master'
  }

  exec { 'autogen-json-c':
    command   => 'sh ./autogen.sh',
    cwd       => '/tmp/json-c',
    require   => [Vcsrepo['json-c']],
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
    path      => [
      '/bin',
      '/usr/local/bin',
      '/usr/bin',
      '/sbin',
      '/usr/sbin'],
    require   => [Exec['make-json-c']],
    logoutput => $debug,
    timeout   => 0
  }
}
