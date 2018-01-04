esgrep
======

esgrep is a simple command line tool that aims to run Kibana like queries from the command line. While Kibana's Discover interface just uses the [Query String Query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html "Elasticsearch Date Type"), it also does some things like searching inside the _source field that this tool seeks to emulate.

Installation
------------
We'll offer .deb and .rpm packages soon(tm), but for now:

1.) Copy bin/esgrep to a folder in your $PATH

2.) Copy config/esgrep.yml to /etc/esgrep/esgrep.yml and add your Elasticsearch server(s) to the es_nodes setting.

Dependencies
------------
You'll need PyYAML and version => 5.0 of python-elasticsearch to run this.

esgrep has been tested on python 2.7.

Usage
-----
    usage: esgrep [-h] [-i INDEX] [-j] [-a] [-ts TIMESTART] [-te TIMEEND]
                  [--timefield TIMEFIELD] [-s SORT] [-f FIELDS]
                  query

Options:
--------
      -h, --help            show this help message and exit
      -i INDEX, --index INDEX
                            index to search against. Supports wildcards (e.g.,
                            logstash-2016.11.01, logstash-2016.10.*,etc). defaults
                            to logstash-YYYY-MM-DD
      -j, --json            return all (_source) fields as json
      -a, --agg             return only aggregations from query
      -ts TIMESTART, --timestart TIMESTART
                            starting timestamp to filter query results by
      -te TIMEEND, --timeend TIMEEND
                            ending timestamp to filter query results by
      --timefield TIMEFIELD
                            field used when applying a time range to a search
                            (defaults to "@timestamp")
      -s SORT, --sort SORT  comma separated list of fields to sort by (defaults to
                            "@timestamp")
      -f FIELDS, --fields FIELDS
                            comma separated list of fields to search (defaults to
                            "*,_source")
