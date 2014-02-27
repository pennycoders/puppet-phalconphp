# Class: phalconphp::deps::sys
# Installs gcc, make, automake, autoconf, re2c, pcre, pcre-devel, libcurl, libcurl-devel, wget
class phalconphp::deps::sys (
  $each_compat = false) {
  case $::osfamily {
    'redhat' : { # Define the package names for rhel
      $phalcon_deps = [
        'gcc',
        'git',
        'autoconf',
        'make',
        'automake',
        're2c',
        'pcre',
        'pcre-devel',
        'openssl',
        'openssl-devel',
        'libcurl',
        'libcurl-devel',
        'wget']
    }
    'Debian' : { # Define the package names for debian
      case $::operatingsystem {
        'ubuntu', 'debian' : {
          $phalcon_deps = [
            'gcc',
            'git',
            'autoconf',
            'make',
            'automake',
            're2c',
            'pcre',
            'pcre-devel',
            'openssl',
            'openssl-devel',
            'libcurl',
            'libcurl-devel',
            'wget']
        }
        default            : {
          fail('Unsupported Debian distro')
        }
      }
    }
    default  : { # fail, unknown OS
      fail('Unknown Operating System')
    }
  }

  if $each_compat == true {
    package { $phalcon_deps: ensure => present }
  } else {
    each($phalcon_deps) |$phalcon_dep| {
      if defined(Package[$phalcon_dep]) == false {
        package { $phalcon_dep: ensure => present }
      }
    }
  }
}
