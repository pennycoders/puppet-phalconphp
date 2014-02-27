# Class: phalconphp::deps::sys
# Installs gcc, make, automake, autoconf, re2c, pcre, pcre-devel, libcurl, libcurl-devel, wget
class phalconphp::deps::sys (
  $each_compat = false) {
  case $::osfamily {
    'RedHat' : { # Define the package names for rhel
      case $::operatingsystem {
        'RedHat', 'Fedora', 'CentOS', 'Scientific', 'SLC', 'Ascendos', 'CloudLinux', 'PSBM', 'OracleLinux', 'OVS', 'OEL' : {
          $packages = [
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
        default : {
          fail('Unsupported RedHAT distro')
        }
      }
    }
    'Debian' : { # Define the package names for debian
      case $::operatingsystem {
        'ubuntu', 'debian' : {
          $packages = [
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
    package { $packages: ensure => present }
  } else {
    each($packages) |$package| {
      if defined(Package[$package]) == false {
        package { $package: ensure => present }
      }
    }
  }
}
