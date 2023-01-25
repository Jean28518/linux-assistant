Name:           linux-assistant
Version:        0.1.5
Release:        1%{?dist}
Summary:        Daily Linux Helper with integrated search
License:        GPL
Source0:        %{name}-%{version}.tar.gz
Requires:       libkeybinder-3_0-0 wmctrl wget python3

%description
Daily Linux Helper with integrated search

%prep
%setup -q

%install
rm -rf %RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/%{_bindir}
mkdir -p $RPM_BUILD_ROOT/%{_libdir}/%{name}
cp -r * $RPM_BUILD_ROOT/%{_libdir}/%{name}
sed -i "s|/usr/lib/|%{_libdir}/|" $RPM_BUILD_ROOT/%{_libdir}/%{name}/%{name}
mv $RPM_BUILD_ROOT/%{_libdir}/%{name}/%{name} $RPM_BUILD_ROOT/%{_bindir}/


%clean
rm -rf $RPM_BUILD_ROOT

%files
%{_bindir}/%{name}
%{_libdir}/%{name}