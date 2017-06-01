# Syscall rules take the general form of:
#
# -a action,list -S syscall -F field=value -k keyname
#
define audit::syscallrule (
                            $action,
                            $syscall,
                            $keyname    = $name,
                            $fields     = [],
                            $fields_eq  = {},
                            $fields_neq = {},
                          ) {
  #
  concat::fragment{ "${audit::params::audit_file} action ${name} ${syscall} ${keyname} ${action}":
    target  => $audit::params::audit_file,
    order   => '11',
    content => template("${module_name}/syscallrule.erb"),
  }
}
