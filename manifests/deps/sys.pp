# Class: phalconphp::deps::sys
# Installs gcc, make, automake, autoconf, re2c, pcre, pcre-devel, libcurl, libcurl-devel, wget
class phalconphp::deps::sys {
  if defined(Package['gcc']) == false {
    package { 'gcc': ensure => present }
  }

  if defined(Package['git']) == false {
    package { 'git': ensure => present }
  }

  if defined(Package['make']) == false {
    package { 'make': ensure => present }
  }

  if defined(Package['automake']) == false {
    package { 'automake': ensure => present }
  }

  if defined(Package['autoconf']) == false {
    package { 'autoconf': ensure => present }
  }

  if defined(Package['re2c']) == false {
    package { 're2c': ensure => present }
  }

  if defined(Package['pcre']) == false {
    package { 'pcre': ensure => present }
  }

  if defined(Package['pcre-devel']) == false {
    package { 'pcre-devel': ensure => present }
  }

  if defined(Package['openssl']) == false {
    package { 'openssl': ensure => present }
  }

  if defined(Package['openssl-devel']) == false {
    package { 'openssl-devel': ensure => present }
  }

  if defined(Package['libcurl']) == false {
    package { 'libcurl': ensure => present }
  }

  if defined(Package['libcurl-devel']) == false {
    package { 'libcurl-devel': ensure => present }
  }

  if defined(Package['wget']) == false {
    package { 'wget': ensure => present }
  }
}
