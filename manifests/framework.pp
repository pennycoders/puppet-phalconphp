# Class: phalconphp::framework
# Installs the actual phalconphp framework
class phalconphp::framework (
  $version,
  $zephir_build = false,
  $ini_file     = "phalcon.ini",
  $debug        = false) {
  vcsrepo { "phalcon":
    ensure   => latest,
    path     => '/tmp/cphalcon',
    provider => git,
    require  => [Class['phalconphp::deps::sys']],
    source   => 'https://github.com/phalcon/cphalcon.git',
    revision => $version
  }

  file { "${php::config_dir}/${ini_file}":
    ensure  => file,
    require => [Class['php']]
  }

  if $version == '2.0.0' or $version == 'dev' {
    if $zephir_build == true {
      exec { 'generate-phalcon-2.0':
        command   => 'zephir generate',
        cwd       => '/tmp/cphalcon',
        require   => [
          Class['phalconphp::deps::zephir'],
          Vcsrepo['phalcon']],
        onlyif    => 'test -f /tmp/cphalcon/config.json',
        logoutput => $debug,
        timeout   => 0
      }

      exec { 'install-phalcon-2.0':
        command   => 'zephir build',
        cwd       => '/tmp/cphalcon',
        require   => [Exec['generate-phalcon-2.0']],
        logoutput => $debug,
        timeout   => 0
      }
    } else {
      exec { 'install-phalcon-2.0':
        command   => "/tmp/cphalcon/ext/install-test",
        cwd       => '/tmp/cphalcon/ext',
        require   => [Exec['git-pull-phalcon']],
        onlyif    => 'test -f /tmp/cphalcon/ext/install-test',
        logoutput => $debug,
        timeout   => 0
      }
    }

    exec { 'remove-phalcon-src-2.0':
      cwd       => '/tmp',
      command   => 'rm ./cphalcon -R -f',
      require   => [Exec['install-phalcon-2.0']],
      logoutput => $debug,
      timeout   => 0
    }

    php::augeas { 'php-load-phalcon-2.0':
      entry   => 'phalconphp/extension',
      value   => 'phalcon.so',
      target  => "${php::config_dir}/${ini_file}",
      require => [
        File["${php::config_dir}/${ini_file}"],
        Exec['remove-phalcon-src-2.0']]
    }
  } else {
    exec { 'install-phalcon-1.x':
      command   => 'sudo ./install',
      cwd       => '/tmp/cphalcon/build',
      onlyif    => 'test -f /tmp/cphalcon/build/install',
      require   => [Vcsrepo['phalcon']],
      logoutput => $debug,
      timeout   => 0
    }

    php::augeas { 'php-load-phalcon-1.x':
      entry   => 'phalconphp/extension',
      target  => "${php::config_dir}/${ini_file}",
      value   => 'phalcon.so',
      require => [
        File["${php::config_dir}/${ini_file}"]
    }
  }
}