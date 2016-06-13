
_osfamily               = fact('osfamily')
_operatingsystem        = fact('operatingsystem')
_operatingsystemrelease = fact('operatingsystemrelease').to_f

case _osfamily
when 'RedHat'
  $packagename     = 'audit'
  $servicename     = 'auditd'

when 'Debian'
  $packagename     = 'auditd'
  $servicename     = 'auditd'

else
  $packagename     = '-_-'
  $servicename     = '-_-'

end
