%define date 20150203
%define commit e8a0d85d0d03ff6ae6312a687bca27732c1bca2f

%define exec_texhash [ -x /usr/bin/texhash ] && /usr/bin/env - /usr/bin/texhash 2> /dev/null
%define texmf_dir %{_datadir}/texlive/texmf-dist/tex/latex/tilatex

Name: tilatex
Version: 0.%{date}git
Release: 1%{?dist}
Summary: LaTeX class for TI exercises
BuildArch: noarch




Group: Applications/Publishing
License: MIT
URL: https://github.com/rwth-ti/tilatex
Source0: https://github.com/rwth-ti/tilatex/archive/%{commit}.tar.gz


%description
LaTeX class for TI exercises


%prep
%setup -qn %{name}-%{commit}


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
* Mon Feb 09 2015 Markus Rothe <rothe@ti.rwth-aachen.de> - 20150209
- Created initial spec file
