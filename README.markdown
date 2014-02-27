# Phalconphp #

    This is the phalconphp module. 
    It installs the phalconphp framework, and optionally,       
    the devtools, as well as all the other dependencies needed by it 

# Example usage:
    
    class {'phalconphp':
            ensure_sys_deps=>true,
            ensure=>'2.0.0', 
            install_devtools=>true,
            devtools_version=>'1.3.x',
            install_zephir=>true,
            compat_sys_deps=>false
    }

# Parameters:
    ensure_sys_deps - Only change to false only if you really know what you are doing.
    ensure - Which version (branch) of phalconphp should be compiled
    install_devtools - Whether or not phalcon devtools should be installed
    devtools_version - Which version (branch) of the devtools should be installed
    install_zephir - Whether or not to install zephir

# Prerequisites:
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

### TODO: 
    Add the ability to create phalconphp projects via puppet