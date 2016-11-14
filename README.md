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
    usage: esgrep [-h] [-i INDEX] query

Options:
--------
    -h: show help message and exit
    -i --index INDEX: index to search against. Supports wildcards (e.g., logstash-2016.11.01, logstash-2016.10.*, etc). defaults to logstash-YYYY-MM-DD
    query: query to search elasticsearch for. See elasticsearch/kibana query string syntax for more info
    
Todo:
-----
Similar to Kibana, allow users to specify (in config/esgrep.yml) a list of indexes along with what field name to use as a timestamp for sorting documents. For now, this tool assuemes a field named "@timestamp" exists and has an Elasticsearch [Date](https://www.elastic.co/guide/en/elasticsearch/reference/current/date.html "Elasticsearch Date Type").
