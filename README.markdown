# Phalcon Puppet module

Puppet is IT automation software that helps system administrators manage infrastructure throughout its lifecycle, from provisioning and configuration to orchestration and reporting. This is a Puppet module that installs Phalcon framework and optionally devtools, as well as all the other dependencies needed by them. 

### Example usage
    
```puppet
class { 'phalconphp':
    ensure_sys_deps => true,
    ensure => 'master', 
    install_devtool => true,
    devtools_version => 'master',
    install_zephir => false,
    compat_sys_deps => false,
    zephir_build => false,
    ini_file => 'phalcon.ini',
    debug => false
}
```    
    
### Required parameters

```bash
ensure
ensure_sys_deps
install_devtools (needs to be se to true)
devtools_version
```

### Parameters

```bash
ensure_sys_deps
ensure 
install_devtools
   devtools_version
install_zephir
   compat_sys_deps
zephir_build
ini_file
debug
```

### Prerequisites

This module can install everything for you, however, in order to be able to achieve that, a few other modules are required:

```bash
puppetlabs/stdlib
example42/yum 
puppetlabs/apt
example42/php 
example42/puppi
```

### Gittip

[![Support the maintainer via Gittip](https://rawgithub.com/twolfson/gittip-badge/0.2.0/dist/gittip.png)](https://www.gittip.com/pennycoders/)

## Notes
 
Values in the Usage example above are the default ones and although they can be changed, I strongly recommend to not change them unless you really need a more specific approach.
    
In regards to compat_sys_deps, see http://forum.phalconphp.com/discussion/1660/phalconphp-puppet-module-compiles-zephir-phalconphp-and-installs
    
This module has been rigurously tested on CentOS 6.5 x64
    
Devtools does not seem to be fully compatible with phalconphp 2.x
    
### TODO
    
* Add the ability to create phalcon projects via puppet
* Add / test support for Debian platforms
    
