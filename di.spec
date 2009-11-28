Name:           di
Version:        4.18
Release:        1%{?dist}
Summary:        'di' is a disk information utility, displaying everything (and more) that your 'df' command does.

Group:          System Environment/Base
License:        zlib/libpng
URL:            http://www.gentoo.com/di/
Source0:        http://www.gentoo.com/di/di-%{version}.tar.gz
Source1:        http://www.sfr-fresh.com/unix/misc/di-%{version}.tar.gz
BuildRoot:      %(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)

#BuildRequires: perl
#Requires:

%description
'di' is a disk information utility, displaying everything
(and more) that your 'df' command does. It features the
ability to display your disk usage in whatever format you
desire/prefer/are used to. It is designed to be portable
across many platforms.

%prep
%setup -q

%build
env LOCALEDIR=/usr/share/locale ./Build -mkc config.h
make LOCALEDIR=/usr/share/locale %{?_smp_mflags}

%install
test -d $RPM_BUILD_ROOT || mkdir $RPM_BUILD_ROOT
test -d $RPM_BUILD_ROOT/usr || mkdir $RPM_BUILD_ROOT/usr
make install prefix=$RPM_BUILD_ROOT/usr
rm -f $RPM_BUILD_ROOT/usr/bin/mi
cd $RPM_BUILD_ROOT/usr/bin/
ln -sf di mi

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
%doc README LICENSE MANIFEST
/usr/bin/di
/usr/bin/mi
/usr/share/locale/de_DE/LC_MESSAGES/di.mo
/usr/share/locale/en_US/LC_MESSAGES/di.mo
/usr/share/man/man1/di.1.gz

%changelog