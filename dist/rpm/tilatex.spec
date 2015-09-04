%define exec_texhash [ -x /usr/bin/texhash ] && /usr/bin/env - /usr/bin/texhash 2> /dev/null
%define texmf_dir %{_datadir}/texlive/texmf-dist/tex/latex/tilatex

Name: tilatex
Version: 20150904
Release: 1%{?dist}
Summary: LaTeX packages and classes for TI
BuildArch: noarch


Group: Applications/Publishing
License: MIT
URL: https://github.com/rwth-ti/tilatex
Source0: https://github.com/rwth-ti/tilatex/archive/%{version}.tar.gz


%description
A collection of LaTeX packages and classes providing common
functionality used at the Institute for Theoretical Information
Technology, RWTH Aachen University, Germany


%prep
%setup -q


%install
mkdir -p %{buildroot}%{texmf_dir}
cp -r src/* %{buildroot}%{texmf_dir}


%post
%{exec_texhash}


%postun
%{exec_texhash}


%files
%doc LICENSE
%{texmf_dir}/*


%changelog
* Wed Feb 18 2015 Markus Rothe <rothe@ti.rwth-aachen.de> - 20150218
- Update to latest tagged version

* Mon Feb 09 2015 Markus Rothe <rothe@ti.rwth-aachen.de> - 20150209
- Created initial spec file
