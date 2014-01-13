# == Class: solr
#
# Apache Solr client deployment.
#
# === Examples
#
#  class { solr: }
#
# === Authors
#
# Jeremy T. Bouse <jeremy.bouse@undergrid.net>
#
# === Copyright
#
# Copyright 2014 UnderGrid Network Services
#
class solr {
  package { 'solr':
    ensure  => installed,
    require => Package['java']
  }
}
