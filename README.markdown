### Phalconphp Puppet module ###

    This is a phalconphp puppet module. 
    It installs the phalconphp framework, and optionally,       
    the devtools, as well as all the other dependencies needed by it 

### Example usage: ###
    
    class {'phalconphp':
            ensure_sys_deps=>true,
            ensure=>'master', 
            install_devtools=>true,
            devtools_version=>'1.3.x',
            install_zephir=>true,
            compat_sys_deps=>false,
            zephir_build=>false,
            ini_file=>'phalcon.ini',
            debug=>false
    }

### Gittip: ###

[![Support via Gittip](https://rawgithub.com/twolfson/gittip-badge/0.2.0/dist/gittip.png)](https://www.gittip.com/pennycoders/)


### Parameters: ###

    ensure_sys_deps
    ensure 
    install_devtools
    devtools_version
    install_zephir
    compat_sys_deps
    zephir_build
    ini_file
    debug

### Prerequisites: ###

    This module can install everything for you, 
    however, in order to be able to achieve that,
    a few other modules are required:
        puppetlabs/stdlib
        example42/yum 
        puppetlabs/apt
        example42/php 
        example42/puppi 

# Notes: 
    
    The values in the Usage example above are the default ones,
    and although they can be changed, i strongly recommend you won't change them,
    unless you really need a more speciffic approach.
    
    In regards to compat_sys_deps:
    
    See http://forum.phalconphp.com/discussion/1660/phalconphp-puppet-module-compiles-zephir-phalconphp-and-installs
    
    This Module has only been rigurously tested on CentOS 6.5 x64
    
    The devtools do not seem to be fully compatibile with phalconphp 2.x
    

### TODO: 
    
    - Add the ability to create phalconphp projects via puppet
    - Add / test support for debian platforms
    