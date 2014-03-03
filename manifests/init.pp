# Class: phalconphp
#
# This module manages phalconphp (http://phalconphp.com)
#
# Parameters:
#
# [*ensure*]
# Which version of the Phalcon PHP Framework should be installed (Defaults to 'master' - for alternative versions, please check out
# https://github.com/phalcon/cphalcon/branches)
#
# [*ensure_sys_deps*]
# Whether or not the system dependencies should be installed (automake, make, libpcre3, libpcre3-devel,json-c, etc)
#
# [*install_zephir*]
# Whether you wish to install zephir or not
#
#[*install_devtools*]
# Whether or not to install the phalconphp dev tools
#
# [*devtools_version*]
# See https://github.com/phalcon/phalcon-devtools/branches for a valid branch name
#
# [*compat_sys_deps*]
# Whether or not to use each
# See
# http://forum.phalconphp.com/discussion/1660/phalconphp-puppet-module-compiles-zephir-phalconphp-and-installs for more details)
#
# [*zephir_build*]
# If this is set to true, the method described below is going to be used to compile the framework:
# https://github.com/phalcon/cphalcon/tree/2.0.0 (See README)
# otherwise, the method described here will be used:
# http://blog.phalconphp.com/post/73525793120/phalcon-2-0-alpha-1-released
#
#
# [*ini_file*]
# Path to the desired ini_file, through which phalconphp will be loaded
#
# [*debug*]
# Make the commands execution more verbose - Defaults to false
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
# class { 'phalconphp':}
#

class phalconphp (
  $ensure           = 'master',
  $ensure_sys_deps  = true,
  $install_zephir   = true,
  $install_devtools = true,
  $devtools_version = '1.3.x',
  $zephir_build     = false,
  $compat_sys_deps  = false,
  $custom_ini       = true,
  $ini_file         = "phalcon.ini",
  $debug            = false) {
  # Install the system dependencies
if $ensure_sys_deps == true {
    class { 'phalconphp::deps::sys': each_compat => $compat_sys_deps }
  }

  # Install zephir
if $install_zephir == true {
    class { 'phalconphp::deps::zephir': debug => $debug }
  }

  # Install the actual framework
class { 'phalconphp::framework':
    version      => $ensure,
    zephir_build => $zephir_build,
    ini_file     => $ini_file,
    debug        => $debug
  }

  # Install the phalconphp dev tools
if $install_devtools == true {
    class { 'phalconphp::deps::devtools':
      version => $devtools_version,
      debug   => $debug
    }
  }
}
