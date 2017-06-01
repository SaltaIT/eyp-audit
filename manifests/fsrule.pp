# File System
#     File System rules are sometimes called watches. These rules are used to audit access to particular files or directories that  you  may  be
#     interested in. If the path given in the rule is a directory, then the rule used is recursive to the bottom of the directory tree excluding
#     any directories that may be mount points. The syntax of these rules generally follow this format:
#
#     -w path-to-file -p permissions -k keyname
#
#     where the permission are any one of the following:
#
#            r - read of the file
#
#            w - write to the file
#
#            x - execute the file
#
#            a - change in the file's attribute
#
define audit::fsrule(
                      $path,
                      $permissions,
                      $keyname = $name,
                    ) {
  #
  concat::fragment{ "${audit::params::audit_file} fsrule ${name} ${path} ${keyname}":
    target  => $audit::params::audit_file,
    order   => '10',
    content => template("${module_name}/fsrule.erb"),
  }
}
