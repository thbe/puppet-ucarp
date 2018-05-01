# ucarp #

[![Build Status](https://travis-ci.org/thbe/puppet-ucarp.png?branch=master)](https://travis-ci.org/thbe/puppet-ucarp)
[![Puppet Forge](https://img.shields.io/puppetforge/v/thbe/ucarp.svg)](https://forge.puppetlabs.com/thbe/ucarp)
[![Coverage Status](https://coveralls.io/repos/thbe/puppet-ucarp/badge.svg?branch=master&service=github)](https://coveralls.io/github/thbe/puppet-ucarp?branch=master)

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with ucarp](#setup)
    * [What ucarp affects](#what-ucarp-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with ucarp](#beginning-with-ucarp)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

The ucarp module provides the installation procedure for UCARP including the setup of
the virtual IP.

##Module Description

The UCARP module provides a virtual IP that can be used in a cluster.

##Setup

###What ucarp affects

* ucarp package.
* ucarp configuration file.
* ucarp alternative service configuration.

###Beginning with ucarp

include '::ucarp' is enough to get you up and running if the parameters point to
proper values.  If you wish to pass in parameters like which servers to use then you
can use:

```puppet
class { '::ucarp':
  virtual_id => '001',
  virtual_ip => '192.168.0.222',
  virtual_if => 'eth0',
  virtual_pw => 'Secret'
}
```

##Usage

All interaction with the ucarp module can do be done through the main ucarp class.
This means you can simply toggle the options in the ucarp class to get at the full
functionality.

###I just want UCARP, what's the minimum I need?

```puppet
include '::ucarp'
```

##Reference

###Classes

* ucarp: Main class, includes all the rest.
* ucarp::install: Handles the packages.
* ucarp::config: Handles the configuration file.
* ucarp::service: Handles the alternative service link.

###Parameters

The following parameters are available in the ucarp module

####`virtual_id`
Set the virtual ID

####`virtual_ip`
Set the virtual IP

####`virtual_if`
Set the virtual Interface

####`virtual_pw`
Set the ucarp password

##Limitations

This module has been built on and tested against Puppet 3.2 and higher.

The module has been tested on:

* CentOS 7

Testing on other platforms has been light and cannot be guaranteed.

Currently only eth0 is supported, using other interfaces result in a rewrite
of the common template.

##Development

If you like to add or improve this module, feel free to fork the module and send
me a merge request with the modification.
