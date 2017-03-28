# BIND Module

## Overview

This module install and configure bind dns server.

## Usage

Default configuration:

```puppet
include bind
```

Change configuration file settings:

```puppet
class { 'bind':
    listen_on       => '127.0.0.1',
    zone            => {
      'example.com' => [
        'type master',
        'file "example.com.db"',
      ],
    },
}
```

Create zone file:

```puppet
bind::zone_file { 'example.com.db':
    file_name       => 'example.com.db',
    nameserver      => 'ns1.example.com.',
    admin           => 'admin@example.com.',
    ttl             => '3600',
    serial          => '1',
    refresh         => '3600',
    retry           => '1800',
    expire          => '3600',
    minimum         => '3600',
    records         => [
'@      IN      NS      ns1.example.com.',
'@      IN      A       192.168.1.105',
'ns1    IN      A       192.168.1.105',
'www    IN      A       192.168.1.105'
    ],
}
```

Other variables:

```puppet
    acl            => {
        'list' => [ 10.128.0.1, 10.128.0.5 ],
    },
    allow_query    => 'localhost',
    allow_update   => 'none',
    allow_transfer => 'none',
    recursion      => 'no',
    blackhole      => 'none',
```
