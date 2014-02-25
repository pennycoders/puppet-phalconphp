# Phalconphp #

    This is the phalconphp module. 
    It installs the phalconphp framework, and optionally,       
    the devtools, as well as all the other dependencies needed by it 

# Example usage:
    
    class {'phalconphp':
            ensure=>'2.0.0', 
            ensure_sys_deps=>true,
    }

# Prerequisites:

    This module can install everything for you, 
    however, in order to be able to achieve that,
    a few other modules are required:
        puppetlabs/stdlib (>=1.0.0)
        example42/yum (>=1.0.0)
        puppetlabs/apt (>=1.0.0)
        example42/php (>=1.0.0)

# Notes: 
        
        This module has only been tested and deployed on CentOS 6.5 64bit
        Any contributions are welcome.