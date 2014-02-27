# Class: phalconphp::deps::sys
# Installs gcc, make, automake, autoconf, re2c, pcre, pcre-devel, libcurl, libcurl-devel, wget
class phalconphp::deps::sys (
  $each_compat = false) {
  case $::osfamily {
    'redhat' : { # Define the package names for rhel
      if $::operatingsystem == 'centos' {
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

      } else {
        fail('Unsupported RedHAT distro')
      }
    }
    'debian' : { # Define the package names for debian
      if $::operatingsystem == 'ubuntu' {
        $phalcon_deps = [
          'git',
          'gcc',
          'make',
          're2c',
          'libpcre3-dev',
          'openssl',
          'libssl-dev',
          'wget',
          'curl',
          'libcurl4',
          'libcurl4-dev',
          'libcurl4-openssl-dev']
      } else {
        fail('Unsupported Debian distro')
      }
    }
    default  : { # fail, unknown OS
      fail('Unknown Operating System')
    }
  }

  each($phalcon_deps) |$package| {
    if defined(Package[$package]) == false {
      package { $package: ensure => present }
    }
  }
}
