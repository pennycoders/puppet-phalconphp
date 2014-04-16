# Class: phalconphp::deps::sys
# Installs gcc, make, automake, autoconf, re2c, pcre, pcre-devel, libcurl, libcurl-devel, wget
class phalconphp::deps::sys (
  $each_compat = false) {
  define safepackage (
    $ensure = present) {
    if !defined(Package[$title]) {
      package { $title: ensure => $ensure }
    }
  }

  case $::osfamily {
    'RedHat' : { # Define the package names for rhel
      case $::operatingsystem {
        'RedHat', 'Fedora', 'CentOS', 'Scientific', 'SLC', 'Ascendos', 'CloudLinux', 'PSBM', 'OracleLinux', 'OVS', 'OEL' : {
          safepackage { 'gcc': }

          safepackage { 'git': }

          safepackage { 'autoconf': }

          safepackage { 'make': }

          safepackage { 'automake': }

          safepackage { 're2c': }

          safepackage { 'pcre': }

          safepackage { 'pcre-devel': }

          safepackage { 'openssl': }

          safepackage { 'openssl-devel': }

          safepackage { 'libcurl': }

          safepackage { 'libcurl-devel': }

          safepackage { 'wget': }

          safepackage { 'php-devel': }
        }
        default : {
          fail('Unsupported RedHAT distro')
        }
      }
    }
    'Debian' : {
      case $::operatingsystem {
        'ubuntu', 'debian' : {
          safepackage { 'gcc': }

          safepackage { 'git': }

          safepackage { 'autoconf': }

          safepackage { 'make': }

          safepackage { 'automake': }

          safepackage { 're2c': }

          safepackage { 'libpcre3': }

          safepackage { 'libpcre3-dev': }

          safepackage { 'libssl1.0.0': }

          safepackage { 'libssl-dev': }

          safepackage { 'libcurl3': }

          safepackage { 'libcurl4-openssl-dev': }

          safepackage { 'wget': }

          safepackage { 'php5-dev': }
        }
        default            : {
          fail('Unsupported Debian distro')
        }
      }
    }
    default  : {
      fail('Unknown Operating System')
    }
  }
}
