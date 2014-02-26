# Class: phalconphp
#
# This module manages phalconphp (http://phalconphp.com)
#
# Parameters:
# [*ensure*]
# Which version of the Phalcon PHP Framework should be installed (Defaults to 'master' - for alternative versions, please check out
# https://github.com/phalcon/cphalcon/branches)
# [*ensure_sys_deps*]
# Whether or not the system dependencies should be installed (automake, make, libpcre3, libpcre3-devel,json-c, etc)
# [*install_zephir*]
# Whether you wish to install zephir or not
# [*install_devtools*]
# Whether or not to install the phalconphp dev tools
# Actions:
# [*devtools_version*]
# See https://github.com/phalcon/phalcon-devtools/branches for a valid branch name
# Requires: see Modulefile
#
# Sample Usage:
# class { 'phalconphp':}
#
class phalconphp (
  $ensure           = '2.0.0',
  $ensure_sys_deps  = true,
  $install_zephir   = true,
  $install_devtools = true,
  $devtools_version = '1.3.x') {
  # Install the system dependencies
  if $ensure_sys_deps == true {
    include phalconphp::deps::sys
  }

  # Install zephir
  if $install_zephir == true {
    include phalconphp::deps::zephir
  }

  # Install the actual framework
  class { 'phalconphp::framework':
    version => $ensure
  }

  # Install the phalconphp dev tools
  if $install_devtools == true {
    class { 'phalconphp::deps::devtools': version => $devtools_version }
  }
}
