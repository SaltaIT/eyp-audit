# audit

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What audit affects](#what-audit-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with audit](#beginning-with-audit)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)
    * [Contributing](#contributing)

## Overview

Basic auditd support

## Module Description

basic support for auditd

## Setup

### What audit affects

manages:
* audit package
* audit service
* /etc/audit/audit.rules

### Setup Requirements

This module requires pluginsync enabled

### Beginning with audit

should work out of the box:
```puppet
class { 'audit': }
```

## Usage

Add default rules:

```puppet
class { 'audit': }
```

tty audit:

```puppet
class { 'audit': }

class { 'audit::tty': }
```

## Reference

### classes

#### audit

* **buffers**: buffers to survive stress events (default: 320)
* **add_default_rules**: add the following default rules - it will apply b64 only if is applicable, same for /etc/sysconfig/network (default: true)
* **manage_logrotate**: add logrotate config file (default: true)
* **logrotate_rotate**     = '4',
* **logrotate_compress**   = true,
* **logrotate_missingok**  = true,
* **logrotate_notifempty** = true,
* **logrotate_frequency**  = 'weekly',

```
-w /var/tmp -p x
-w /tmp -p x
-w /home -p x
#Record Events That Modify Date and Time Information
-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change
-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change
-a always,exit -F arch=b64 -S clock_settime -k time-change
-a always,exit -F arch=b32 -S clock_settime -k time-change
-w /etc/localtime -p wa -k time-change
#Record Events That Modify User/Group Information
-w /etc/group -p wa -k identity
-w /etc/passwd -p wa -k identity
-w /etc/gshadow -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/security/opasswd -p wa -k identity
#Record Events That Modify the System\'s Network Environment
-a exit,always -F arch=b64 -S sethostname -S setdomainname -k system-locale
-a exit,always -F arch=b32 -S sethostname -S setdomainname -k system-locale
-w /etc/issue -p wa -k system-locale
-w /etc/issue.net -p wa -k system-locale
-w /etc/hosts -p wa -k system-locale
-w /etc/sysconfig/network -p wa -k system-locale
#Collect Login and Logout Events
-w /var/log/faillog -p wa -k logins
-w /var/log/lastlog -p wa -k logins
-w /var/log/btmp -p wa -k session
#Collect Session Initiation Information
-w /var/run/utmp -p wa -k session
-w /var/log/wtmp -p wa -k session
#Collect Discretionary Access Control Permission Modification Events
-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=500  -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=500  -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=500  -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=500  -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S  lremovexattr -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S  lremovexattr -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod
#Collect Unsuccessful Unauthorized Access Attempts to Files
-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate  -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k access
-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate  -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k access
-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate  -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k access
-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate  -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k access
#Collect mount system call by non-privileged user
-a always,exit -F arch=b64 -S mount -F auid>=500 -F auid!=4294967295 -k mounts
-a always,exit -F arch=b32 -S mount -F auid>=500 -F auid!=4294967295 -k mounts
#Collect File Deletion Events by User
-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=500  -F auid!=4294967295 -k delete
-a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -F auid>=500  -F auid!=4294967295 -k delete
#Collect Changes to System Administration Scope
-w /etc/sudoers -p wa -k scope
#Collect Kernel Module Loading and Unloading
-w /sbin/insmod -p x -k modules
-w /sbin/rmmod -p x -k modules
-w /sbin/modprobe -p x -k modules
```

#### audit::tty

* **disable**: For each user matching one of comma-separated glob patterns, disable TTY auditing (default: \*)
* **enable**: For each user matching one of comma-separated glob patterns, disable TTY auditing This overrides any previous disable option matching the same user name on the command line.  (default: \*)

## Limitations

Tested on:
* CentOS 5
* CentOS 6
* CentOS 7
* Ubuntu 14.04
* SLES11SP3

## Development

We are pushing to have acceptance testing in place, so any new feature should
have some test to check both presence and absence of any feature

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
