# Maintainer: Sébastien Luttringer <seblu@aur.archlinux.org>
# Contributor: Angel Velasquez <angvp@archlinux.org>
# Contributor: tobias <tobias@archlinux.org>
# Contributor: dibblethewrecker dibblethewrecker.at.jiwe.dot.org

pkgname=rxvt-unicode
pkgver=9.16
pkgrel=1
pkgdesc='An unicode enabled rxvt-clone terminal emulator (urxvt)'
arch=('i686' 'x86_64')
url='http://software.schmorp.de/pkg/rxvt-unicode.html'
license=('GPL')
depends=('libxft' 'gdk-pixbuf2' 'perl' 'startup-notification')
optdepends=('gtk2-perl: to use the urxvt-tabbed')
source=(
  "http://dist.schmorp.de/rxvt-unicode/$pkgname-$pkgver.tar.bz2"
  'urxvt.desktop'
  'urxvtc.desktop'
  'urxvt-tabbed.desktop'
)
md5sums=('2e2942e8367624affebc0568e3671b66'
         '88d8786d74b819450adf722180db09fd'
         'bebf5b6b399b74b557fcedbdb47cc387'
         '2604896bb107fbb5511bfd6f46d65894')

build() {
  cd $pkgname-$pkgver
  ./configure \
    --prefix=/usr \
    --with-terminfo=/usr/share/terminfo \
    --enable-256-color \
    --enable-combining \
    --enable-fading \
    --enable-font-styles \
    --enable-iso14755 \
    --enable-keepscrolling \
    --enable-lastlog \
    --enable-mousewheel \
    --enable-next-scroll \
    --enable-perl \
    --enable-pixbuf \
    --enable-pointer-blank \
    --enable-rxvt-scroll \
    --enable-selectionscrolling \
    --enable-slipwheeling \
    --enable-smart-resize \
    --enable-startup-notification \
    --enable-transparency \
    --enable-unicode3 \
    --enable-utmp \
    --enable-wtmp \
    --enable-xft \
    --enable-xim \
    --enable-xterm-scroll \
    --disable-frills
  make
}

package() {
  pushd $pkgname-$pkgver
  # workaround terminfo installation
  export TERMINFO="$pkgdir/usr/share/terminfo"
  install -d "$TERMINFO"
  make DESTDIR="$pkgdir" install
  # install the tabbing wrapper ( requires gtk2-perl! )
  sed -i 's/\"rxvt\"/"urxvt"/' doc/rxvt-tabbed
  install -Dm 755 doc/rxvt-tabbed "$pkgdir/usr/bin/urxvt-tabbed"
  popd
  # install freedesktop menu
  for _f in urxvt urxvtc urxvt-tabbed; do
    install -Dm644 $_f.desktop "$pkgdir/usr/share/applications/$_f.desktop"
  done
}

# vim:set ts=2 sw=2 et:
