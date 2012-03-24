# Maintainer: Sébastien Luttringer <seblu@aur.archlinux.org>
# Contributor: Angel Velasquez <angvp@archlinux.org> 
# Contributor: tobias <tobias@archlinux.org>
# Contributor: dibblethewrecker dibblethewrecker.at.jiwe.dot.org

pkgname=rxvt-unicode
pkgver=9.15
pkgrel=1
pkgdesc='An unicode enabled rxvt-clone terminal emulator (urxvt)'
arch=('i686' 'x86_64')
url='http://software.schmorp.de/pkg/rxvt-unicode.html'
license=('GPL')
depends=('gcc-libs' 'libxft' 'gdk-pixbuf2' 'perl')
optdepends=('gtk2-perl: to use the urxvt-tabbed')
source=(
  "http://dist.schmorp.de/rxvt-unicode/$pkgname-$pkgver.tar.bz2"
  "$pkgname.desktop"
)
md5sums=('15595aa326167ac5eb68c28d95432faf'
         '3de6c13126a45bc3bc9f6bba077a1311')

build() {
  cd $pkgname-$pkgver
  ./configure --prefix=/usr \
    --with-terminfo=/usr/share/terminfo \
    --enable-256-color \
    --enable-font-styles \
    --enable-xim \
    --enable-keepscrolling \
    --enable-selectionscrolling \
    --enable-smart-resize \
    --enable-pixbuf \
    --enable-transparency \
    --enable-utmp \
    --enable-wtmp \
    --enable-lastlog \
    --disable-frills
  make
}

package() {
  cd "$srcdir/$pkgname-$pkgver"
  install -d "$pkgdir/usr/share/terminfo"
  export TERMINFO="$pkgdir/usr/share/terminfo"
  make DESTDIR="$pkgdir" install
 # install the tabbing wrapper ( requires gtk2-perl! )
  sed -i 's/\"rxvt\"/"urxvt"/' doc/rxvt-tabbed
  install -Dm 755 doc/rxvt-tabbed "$pkgdir/usr/bin/urxvt-tabbed"
 # install freedesktop menu
  install -Dm644 ../$pkgname.desktop \
    "$pkgdir/usr/share/applications/$pkgname.desktop"
}

# vim:set ts=2 sw=2 ft=sh et:
