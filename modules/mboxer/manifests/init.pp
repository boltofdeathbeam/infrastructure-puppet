#/etc/puppet/modules/mboxer/manifests/init.pp

# class for mboxer - automatic archiving of ASF email.
class mboxer (

){

  $archive_dir    = '/x1/archives'
  $private_dir    = '/x1/private'
  $root_dir    = '/x1/restricted'
  $install_base  = '/usr/local/etc/mboxer'

# Packages
package {
    'python3-yaml':
      ensure => installed;
}

# apmail user/group
user { 'apmail':
    ensure => present,
    home   => '/home/apmail'
  }

file {
# Tools dir
    $install_base:
      ensure  => directory,
      recurse => true,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      source  => 'puppet:///modules/mboxer',
      require => Package['python3-yaml'];
# mbox archive
    $archive_dir:
      ensure => directory,
      owner  => 'nobody',
      group  => 'apmail',
      mode   => '0705';
    $private_dir:
      ensure => directory,
      owner  => 'nobody',
      group  => 'apmail',
      mode   => '0705';
    $root_dir:
      ensure => directory,
      owner  => 'nobody',
      group  => 'root-sudoers',
      mode   => '0700';
  }
mailalias {
    'archiver':
      ensure    => present,
      name      => 'archiver',
      provider  => aliases,
      recipient => "|python3 ${install_base}/tools/archive.py";
    'private':
      ensure    => present,
      name      => 'private',
      provider  => aliases,
      recipient => "|python3 ${install_base}/tools/archive.py private";
    'restricted':
      ensure    => present,
      name      => 'restricted',
      provider  => aliases,
      recipient => "|python3 ${install_base}/tools/archive.py restricted";
    'chairman':
      ensure    => present,
      name      => 'chairman',
      provider  => aliases,
      recipient => "|python3 ${install_base}/tools/archive.py --lid chairman@apache.org";
    'ea':
      ensure    => present,
      name      => 'ea',
      provider  => aliases,
      recipient => "|python3 ${install_base}/tools/archive.py --lid ea@apache.org";
    'president':
      ensure    => present,
      name      => 'president',
      provider  => aliases,
      recipient => "|python3 ${install_base}/tools/archive.py --lid president@apache.org";
    'secretary':
      ensure    => present,
      name      => 'secretary',
      provider  => aliases,
      recipient => "|python3 ${install_base}/tools/archive.py --lid secretary@apache.org";
    'treasurer':
      ensure    => present,
      name      => 'treasurer',
      provider  => aliases,
      recipient => "|python3 ${install_base}/tools/archive.py --lid treasurer@apache.org";
    'zztest':
      ensure    => present,
      name      => 'zztest',
      provider  => aliases,
      recipient => "|python3 ${install_base}/tools/archive.py --lid zztest@infra.apache.org";
  }
}
