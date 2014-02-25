# Class: phalconphp::deps::git
# Installs git
class phalconphp::deps::git {
  if defined(Package['git']) == false {
    package { 'git': ensure => present }
  }
}
