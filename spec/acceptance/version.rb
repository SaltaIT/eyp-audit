
_osfamily               = fact('osfamily')
_operatingsystem        = fact('operatingsystem')
_operatingsystemrelease = fact('operatingsystemrelease').to_f

case _osfamily
when 'RedHat'
  $packagename     = 'audit'
  $servicename     = 'auditd'
  case
  when _operatingsystemrelease >= 7
    $audit_file    = '/etc/audit/rules.d/eyp-audit.rules'
  else
    $audit_file    = '/etc/audit/audit.rules'
  end

when 'Debian'
  $packagename     = 'auditd'
  $servicename     = 'auditd'
  case
  when _operatingsystemrelease >= 18
    $audit_file    = '/etc/audit/rules.d/audit.rules'
  else
    $audit_file    = '/etc/audit/audit.rules'
  end

else
  $packagename     = '-_-'
  $servicename     = '-_-'
  $audit_file      = '-_-'

end
