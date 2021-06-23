esgrep
======

esgrep is a simple command line tool that aims to run Kibana like queries from the command line. While Kibana's Discover interface just uses the [Query String Query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html "Elasticsearch Date Type"), it also does some things like searching inside the _source field that this tool seeks to emulate.

Installation
------------
An rpm is packaged with this release. To manually install:

1.) install the elasticsearch python library.

2.) Copy bin/esgrep to a folder in your $PATH

3.) Copy config/esgrep.yml to /etc/esgrep/esgrep.yml and add your Elasticsearch server(s) and username/password used to authenticate to elasticsearch.

Dependencies/tested versions
------------
- python 3.6
- PyYAML 3.10 - https://pypi.org/project/PyYAML/ (an rpm should be included in the base repo of most distros)
- python-elasticsearch 7.9.1 - https://pypi.org/project/elasticsearch/


Usage
-----

    usage: esgrep [-h] [-i INDEX] [-t TIMEOUT] [-f FORMAT] [-a] [-S]
                  [-ts TIMESTART] [-te TIMEEND] [--timefield TIMEFIELD] [-s SORT]
                  [-r] [-F FIELDS]
                  query

Options:
--------

    positional arguments:
      query                 query string query to pass to Elasticsearch, OR a file
                            containing an Elasticsearch query (using the full
                            Elasticsearch query DSL)

    optional arguments:
      -h, --help            show this help message and exit
      -i INDEX, --index INDEX
                            index to search against. Supports wildcards (e.g.,
                            {0}-2016.11.01, {0}-2016.10.*,etc). defaults to
                            logstash-*
      -t TIMEOUT, --timeout TIMEOUT
                            how long to wait for a response from Elasticsearch
                            (defaults to 30 seconds)
      -f FORMAT, --format FORMAT
                            format to return data in (json, txt)
      -a, --agg             return only aggregations from query
      -S, --sql             use SQL query syntax
      -ts TIMESTART, --timestart TIMESTART
                            starting timestamp to filter query results by
      -te TIMEEND, --timeend TIMEEND
                            ending timestamp to filter query results by
      --timefield TIMEFIELD
                            field used when applying a time range to a search
                            (defaults to "@timestamp")
      -s SORT, --sort SORT  comma separated list of fields to sort by (defaults to
                            "@timestamp"). Order is ascending by default.
      -r, --reverse         sort any fields passed to -s / --sortdescending
                            instead of the default of ascending
      -F FIELDS, --fields FIELDS
                            comma separated list of fields to search (defaults to
                            "*,_source")
