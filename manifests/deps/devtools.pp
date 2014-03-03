# Class: phalcon::deps::devtools
# Installs the phalconphp devtools
# Parameters:
# [*version*] - desired devtools version  - See https://github.com/phalcon/phalcon-devtools/branches for valid branch names
class phalconphp::deps::devtools (
  $version = '1.3.x',
  $debug   = false) {
  exec { 'git-clone-devtools':
    command   => "sudo git clone https://github.com/phalcon/phalcon-devtools.git -b ${version}",
    cwd       => "/usr/share/php",
    unless    => "test -d ./phalcon-devtools",
    require   => [
      Package['php'],
      Class['phalconphp::deps::sys']],
    logoutput => $debug
  }

  exec { 'git-pull-devtools':
    command   => "sudo git pull",
    cwd       => "/usr/share/php/phalcon-devtools",
    onlyif    => "sudo test -d ./phalcon-devtools",
    require   => [Exec['git-clone-devtools']],
    logoutput => $debug
  }

  file { '/usr/bin/phalcon':
    ensure   => link,
    path     => '/usr/bin/phalcon',
    target   => "/usr/share/php/phalcon-devtools/phalcon.php",
    require  => [
      Class['phalconphp::framework'],
      Exec['git-pull-devtools']],
    loglevel => 'notice'
  }

  file { '/usr/share/php/phalcon-devtools':
    ensure  => directory,
    recurse => true,
    owner   => 'www-data',
    group   => 'www-data',
    require => [Exec['git-pull-devtools']]
  }

  exec { 'chmod+x-devtools':
    command   => 'chmod ugo+x /usr/bin/phalcon',
    require   => [
      File['/usr/share/php/phalcon-devtools'],
      File['/usr/bin/phalcon']],
    logoutput => $debug
  }
}
