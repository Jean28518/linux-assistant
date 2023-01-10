#!/bin/bash
chmod +x additional/python/run_script.py
#flutter build linux
cp -r additional build/linux/x64/release/bundle/
mkdir -p arch/logo
cp -r build/linux/x64/release/bundle/* arch/
cp -r deb/usr/share/icons/hicolor/* arch/logo/
cp -r deb/usr/share/applications/linux_assistant.desktop arch/linux_assistant.desktop
sed 's/icons\/hicolor/linux_assistant\/logo/' arch/linux_assistant.desktop > arch/linux.desktop
sed 's/Exec=linux-assistant/Exec=\/usr\/share\/linux_assistant\/linux_assistant/' arch/linux.desktop > arch/linux_assistant.desktop

echo "/usr/share/linux_assistant/linux_assistant &">arch/la_start.sh

echo "# Maintainer: AndraNux
pkgname=linux-assistant
pkgver=0.1.4
pkgrel=1
pkgdesc='Daily Linux Helper with integrated search'
arch=('x86_64' 'amd64')
url='https://github.com/Jean28518/linux-assistant'
license=('GPL3')
depends=(
  'wmctrl'
  'libkeybinder3'
)

source=('linux_assistant')
sha256sums=('SKIP')

package() {
	mkdir -p \"\$pkgdir/usr/share/linux_assistant/\"
	mkdir -p \"\$pkgdir/usr/bin/\"

	cp -r \"\$startdir/additional\" \"\$pkgdir/usr/share/linux_assistant/\"
	cp -r \"\$startdir/data\" \"\$pkgdir/usr/share/linux_assistant/\"

	cd \"\$startdir/lib\"
	for file in *.so ; do
		install -Dm644 \"\$file\" \"\$pkgdir/usr/share/linux_assistant/lib/\$file\";
	done

	cp -r \"\$startdir/logo\" \"\$pkgdir/usr/share/linux_assistant/\"

	install -Dm777 \"\$startdir/la_start.sh\" \"\$pkgdir/usr/bin/linux_assistant\"
	install -Dm777 \"\$startdir/linux_assistant\" \"\$pkgdir/usr/share/linux_assistant/linux_assistant\"
	install -Dm755 \"\$startdir/linux_assistant.desktop\" \"\$pkgdir/usr/share/applications/linux_assistant.desktop\"

	chmod -R 777 \"\$pkgdir/usr/share/linux_assistant/additional\"
	chmod -R 777 \"\$pkgdir/usr/share/linux_assistant/data\"
	chmod -R 777 \"\$pkgdir/usr/share/linux_assistant/lib\"
}">arch/PKGBUILD
