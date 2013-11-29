# ucarp #

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
  vId => '001',
  vIp => '192.168.0.222',
  vIf => 'eth0',
  vPw => 'Secret'
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

####`vId`
Set the virtual ID

####`vIp`
Set the virtual IP

####`vIf`
Set the virtual Interface

####`vPw`
Set the ucarp password

##Limitations

This module has been built on and tested against Puppet 3.2 and higher.

The module has been tested on:

* RedHat Enterprise Linux 6
* Scientific Linux 6

Testing on other platforms has been light and cannot be guaranteed. 

##Development

If you like to add or improve this module, feel free to fork the module and send
me a merge request with the modification.

##Copyright and License
Copyright (C) 2013 Thomas Bendler

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
