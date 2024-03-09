# Maintainer: Jean28518@Github
pkgname=linux-assistant
pkgdesc="A daily linux helper with powerful integrated search, routines and checks."
pkgver=0.4.4
pkgrel=1
arch=('x86_64')
license=('GPL-3.0-or-later')

source=("https://github.com/Jean28518/linux-assistant/releases/latest/download/linux-assistant-bundle.zip")

depends=("libkeybinder3", "wmctrl", "wget", "python", "mesa-utils", "polkit")

package() {
    mkdir -p "$pkgdir/usr/bin"
    cp -f "$srcdir/linux-assistant-bundle/linux-assistant.sh" "$pkgdir/usr/bin/linux-assistant"
    chmod +x "$srcdir/usr/bin/linux-assistant"

    mkdir -p "$pkgdir/usr/share/polkit-1/actions"
    cp -f "$srcdir/linux-assistant-bundle/org.linux-assistant.operations.policy" "$pkgdir/usr/share/polkit-1/actions/org.linux-assistant.operations.policy"

    mkdir -p "$pkgdir/usr/share/applications"
    cp -f "$srcdir/linux-assistant-bundle/linux-assistant.desktop" "$pkgdir/usr/share/applications/linux-assistant.desktop"

    mkdir -p "$pkgdir/usr/share/icons/hicolor/256x256/apps"
    cp -f "$srcdir/linux-assistant-bundle/linux-assistant.png" "$pkgdir/usr/share/icons/hicolor/256x256/apps/linux-assistant.png"

    mkdir -p "$pkgdir/usr/lib/linux-assistant"
    cp -r "$srcdir/linux-assistant-bundle/lib" "$pkgdir/usr/lib/linux-assistant/"
    cp -r "$srcdir/linux-assistant-bundle/data" "$pkgdir/usr/lib/linux-assistant/"
    cp -r "$srcdir/linux-assistant-bundle/additional" "$pkgdir/usr/lib/linux-assistant/"
    cp -f "$srcdir/linux-assistant-bundle/version" "$pkgdir/usr/lib/linux-assistant/"
    cp -f "$srcdir/linux-assistant-bundle/linux-assistant" "$pkgdir/usr/lib/linux-assistant/"


  tar -czf "$pkgname-$pkgver-$arch.pkg.tar.gz" -C "$pkgdir" .
}