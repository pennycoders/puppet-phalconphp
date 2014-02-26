# Class: phalconphp::deps::sys
# Installs gcc, make, automake, autoconf, re2c, pcre, pcre-devel, libcurl, libcurl-devel, wget
class phalconphp::deps::sys {
  case $::osfamily {
    'redhat' : { # Define the package names for rhel
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
    'debian' : { # Define the package names for debian
      $packages = [
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
    }
    default  : { # fail, unknown OS
      fail('Unknown Operating System')
    }
  }

  each($packages) |$key, $package| {
    if defined(Package[$package]) == false {
      package { $package: ensure => present }
    }
  }
}

