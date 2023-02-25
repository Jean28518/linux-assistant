Name:           linux-assistant
Version:        0.1.8
Release:        1%{?dist}
Summary:        Daily Linux Helper with integrated search
License:        GPL
Source0:        %{name}-%{version}.tar.gz
Requires:       libkeybinder-3_0-0 wmctrl wget python3
Provides:       libflutter_linux_gtk.so()(64bit) libhotkey_manager_plugin.so()(64bit)

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

mkdir -p $RPM_BUILD_ROOT/%{_datadir}/icons/hicolor/scalable/apps/
mv $RPM_BUILD_ROOT/%{_libdir}/%{name}/linux-assistant.svg $RPM_BUILD_ROOT/%{_datadir}/icons/hicolor/scalable/apps/
mkdir -p $RPM_BUILD_ROOT/%{_datadir}/icons/hicolor/256x256/apps/
mv $RPM_BUILD_ROOT/%{_libdir}/%{name}/linux-assistant.png $RPM_BUILD_ROOT/%{_datadir}/icons/hicolor/256x256/apps/
mkdir -p $RPM_BUILD_ROOT/%{_datadir}/applications/
mv $RPM_BUILD_ROOT/%{_libdir}/%{name}/linux_assistant.desktop $RPM_BUILD_ROOT/%{_datadir}/applications/
mkdir -p $RPM_BUILD_ROOT/%{_datadir}/polkit-1/actions/
mv $RPM_BUILD_ROOT/%{_libdir}/%{name}/org.linux-assistant.operations.policy $RPM_BUILD_ROOT/%{_datadir}/polkit-1/actions/


%clean
rm -rf $RPM_BUILD_ROOT

%files
%{_bindir}/%{name}
%{_libdir}/%{name}
%{_datadir}/polkit-1/actions/org.linux-assistant.operations.policy
%{_datadir}/applications/linux_assistant.desktop
%{_datadir}/icons/hicolor/scalable/apps/linux-assistant.svg
%{_datadir}/icons/hicolor/256x256/apps/linux-assistant.png