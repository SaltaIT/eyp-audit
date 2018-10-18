# CHANGELOG

## 0.1.17

* added tcp_listen_port variable

## 0.1.16

* added SLES 12.3 support

## 0.1.15

* added Ubuntu 18.04 support

## 0.1.14

* added flag to enable logging changes of login logs

## 0.1.13

* added default security rules using flags to be able to enable a subset:
  * **log_alter_time**
  * **log_dac**
  * **log_netconf_changes**
  * **log_file_deletions**
  * **log_export_media**
  * **log_kmod_load_unload**
  * **log_priv_commands**

## 0.1.12

* bugfix **audit::fsrule** and **audit::syscallrule**

## 0.1.11

* rules management:
  * audit::syscallrule
  * audit::fsrule

## 0.1.10

* added Ubuntu 16.04 support

## 0.1.9

* removed **audit::tty** (moved to **pam::ttyaudit**)

## 0.1.8

* added **::logrotate** as a dependency

## 0.1.7

* fixed typo

## 0.1.6

* logrotate configuration file using eyp-logrotate (manage_logrotate=>false to disable)
