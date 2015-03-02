include apt

Exec {
  path => [ "/bin/", "/sbin" , "/usr/bin", "/usr/sbin" ]
}

apt::source { "percona":
  location   => "http://repo.percona.com/apt",
  release    => "trusty",
  repos      => "main",
  key        => "1C4CBDCDCD2EFD2A",
  key_server => "keys.gnupg.net"
}

apt::source { "hhvm":
  location    => "http://dl.hhvm.com/ubuntu",
  release     => "trusty",
  repos       => "main",
  key         => 0x5a16e7281be7a449,
  key_server  => "keyserver.ubuntu.com",
  include_src => false
}

exec { "apt update":
  command  => "/usr/bin/apt-get update",
  require  => [ Apt::Source["hhvm"], Apt::Source["percona"]  ]
}

exec { "apt upgrade":
  command => "/usr/bin/apt-get -y upgrade",
  require => Exec["apt update"]
}

Package {
  ensure  => "installed",
  require => Exec["apt upgrade"]
}

$baseApplications = [
  "hhvm",
  "nginx",
  "percona-server-client-5.5",
  "percona-server-server-5.5",
  "software-properties-common",
  "vim"
]

package { $baseApplications:  }

file { "/etc/nginx/sites-available/default":
  before  => File["/etc/nginx/sites-enabled/default"],
  mode    => 644,
  owner   => root,
  group   => root,
  require => Package["nginx"],
  source  => "/vagrant/provision/guest/etc/nginx/sites-available/default"
}

file { "/etc/nginx/sites-enabled/default":
  ensure  => "link",
  target  => "/etc/nginx/sites-available/default"
}

exec { "service nginx reload":
  require => File["/etc/nginx/sites-enabled/default"]
}

exec { "service hhvm start":
  require => Package["hhvm"]
}

exec { "hhvm startup":
  command => "update-rc.d hhvm defaults",
  require => Package["hhvm"]
}

