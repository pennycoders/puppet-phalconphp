# Class: phalcon::deps::devtools
# Installs the phalconphp devtools
# Parameters:
# [*version*] - desired devtools version  - See https://github.com/phalcon/phalcon-devtools/branches for valid branch names
class phalconphp::deps::devtools (
  $version = '1.3.x',
  $debug   = false) {
  vcsrepo { "devtools":
    ensure   => latest,
    path     => '/usr/share/php/phalcon-devtools',
    provider => git,
    source   => 'https://github.com/phalcon/phalcon-devtools.git',
    revision => $version
  }

  file { '/usr/bin/phalcon':
    ensure  => link,
    path    => '/usr/bin/phalcon',
    target  => "/usr/share/php/phalcon-devtools/phalcon.php",
    require => [
      Class['phalconphp::deps::sys'],
      Class['phalconphp::framework'],
      Vcsrepo['devtools']]
  }

  file { '/usr/share/php/phalcon-devtools':
    ensure  => directory,
    recurse => true,
    owner   => $::ssh_username,
    require => [Vcsrepo['devtools']]
  }

  exec { 'chmod+x-devtools':
    command   => 'chmod ugo+x /usr/bin/phalcon',
    require   => [
      File['/usr/share/php/phalcon-devtools'],
      File['/usr/bin/phalcon']],
    logoutput => $debug,
    timeout   => 0
  }
}
