Name:		esgrep
Version:	1.4
Release:	0%{dist}
Summary:	Tool for running Kibana style queries from the command line

Group:		Applications/System
License:	none
URL:		N/A
Source0:	esgrep-1.4-0.tar.gz
BuildRoot:	%(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)
BuildArch:	noarch
Requires: python, python-elasticsearch, PyYAML


%description
esgrep is a simple command line tool that aims to run Kibana like queries from the command line. While Kibana's Discover interface just uses the Query String Query, it also does some things like searching inside the _source field that this tool seeks to emulate. Queries may also be run using the full Elasticsearch DSL

%prep
%setup -q


%build


%install
rm -rf %{buildroot}
mkdir -p %{buildroot}/usr/local/bin/
mkdir -p %{buildroot}/etc/esgrep/
install -m 0755 esgrep %{buildroot}/usr/local/bin/esgrep
install -m 0644 esgrep.yml %{buildroot}/etc/esgrep/esgrep.yml

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root,-)
/usr/local/bin/esgrep
/etc/esgrep/esgrep.yml


%changelog
* Tue Nov 13 2018 Ted Wells <twells@nexcess.net> - 1.4
- don't show program field by default
- use request_timeout param instead of timeout
* Mon Jan 15 2018 Ted Wells <twells@nexcess.net> - 1.3
- add -t/--timeout flags
* Thu Jan 04 2018 Ted Wells <twells@nexcess.net> - 1.2
- initial (rpm) release
