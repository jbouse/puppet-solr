# == Class: solr::server
#
# Apache Solr server deployment
#
# === Parameters
#
# [*zk_ensemble*]
#   (Array) An array of hostname:port records that make up
#   the Zookeeper ensemble.
#
# [*solr_port*]
#   (Integer) The port to listen for connections
#
# [*admin_port*]
#   (Integer) The port to listen for admin connections
#
# [*solr_xml*]
#   (String) template path to deploy for solr.xml on initial setup
#
# === Examples
#
#  class { 'solr::server':
#    zk_ensemble => ['zk1.example.com:2181', 'zk2.example.com:2181', 'zk3.example.com:2181'],
#    solr_port   => 8983,
#    admin_port  => 8984,
#  }
#
# === Authors
#
# Jeremy T. Bouse <jeremy.bouse@undergrid.net>
#
# === Copyright
#
# Copyright 2014 UnderGrid Network Services
#
class solr::server (
  $zk_ensemble = $::solr::params::zk_ensemble,
  $solr_port   = $::solr::params::solr_port,
  $admin_port  = $::solr::params::admin_port,
  $solr_xml    = $::solr::params::solr_xml,
  $schema_xml  = $::solr::params::schema_xml,
  $solrconfig  = $::solr::params::solrconfig,
) inherits solr::params {

  package { 'solr-server':
    ensure  => installed,
    require => Package['java']
  }

  service { 'solr-server':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['solr-server'],
    subscribe  => File['/etc/default/solr'],
  }

  file { '/etc/default/solr':
    content => template('solr/solr.erb'),
    require => Package['solr-server'],
    before  => Service['solr-server'],
  }

}
