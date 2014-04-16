# Class: phalconphp::framework
# Installs the actual phalconphp framework
class phalconphp::framework (
  $version,
  $zephir_build = false,
  $ini_file     = "phalcon.ini",
  $debug        = false,
  $tmpdir       = '/tmp/cphalcon') {
  vcsrepo { "phalcon":
    ensure   => latest,
    path     => $tmpdir,
    provider => git,
    source   => 'https://github.com/phalcon/cphalcon.git',
    revision => $version
  }

  if $version == '2.0.0' or $version == 'dev' {
    if $zephir_build == true {
      exec { 'generate':
        require   => [
          Class['phalconphp::deps::zephir'],
          Vcsrepo['phalcon'],
          ],
        command   => 'zephir generate',
        cwd       => $workdir,
        path      => [
          '/bin',
          '/usr/bin',
          '/sbin',
          '/usr/sbin'],
        onlyif    => "test -f ${workdir}/config.json",
        logoutput => $debug,
        timeout   => 0
      } ->
      exec { 'install':
        command   => 'zephir build',
        cwd       => $workdir,
        path      => [
          '/bin',
          '/usr/bin',
          '/sbin',
          '/usr/sbin'],
        logoutput => $debug,
        timeout   => 0
      }
    } else {
      exec { 'install':
        require   => [
          Vcsrepo['phalcon'],
          Class['phalconphp::deps::sys'],
          ],
        command   => "${workdir}/ext/install-test",
        cwd       => "${workdir}/ext",
        path      => [
          '/bin',
          '/usr/bin',
          '/sbin',
          '/usr/sbin'],
        onlyif    => "test -f ${workdir}/ext/install-test",
        logoutput => $debug,
        timeout   => 0
      }
    }
  } else {
    exec { 'install':
      require   => [
        Vcsrepo['phalcon'],
        Class['phalconphp::deps::sys'],
        ],
      onlyif    => "test -f ${workdir}/build/install",
      command   => 'sudo ./install',
      cwd       => "${workdir}/build",
      path      => [
        '/bin',
        '/usr/bin',
        '/sbin',
        '/usr/sbin'],
      logoutput => $debug,
      timeout   => 0
    }
  }

  php::module { 'phalcon': require => Exec['clean'] }
}
