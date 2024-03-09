# Build bundle
VERSION="$( cat version )"

sed -i "s/pkgver=.*/pkgver=\"$VERSION\"/" pkg/PKGBUILD

makepkg -s --skipchecksums