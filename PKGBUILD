# vim: ts=2 sw=2 et:
#
# Maintainer: George Rawlinson <grawlinson@archlinux.org>
# Contributor: Levente Polyak <anthraxx[at]archlinux[dot]org>
# Contributor: Sébastien Luttringer
# Contributor: Angel Velasquez <angvp@archlinux.org>
# Contributor: tobias <tobias@archlinux.org>
# Contributor: dibblethewrecker dibblethewrecker.at.jiwe.dot.org

pkgbase=rxvt-unicode-cvs
pkgname=('rxvt-unicode-cvs' 'rxvt-unicode-terminfo-cvs')
pkgver=20240204.164417
pkgrel=1
epoch=1
arch=('x86_64')
url='http://software.schmorp.de/pkg/rxvt-unicode.html'
license=('GPL')
makedepends=(
  'libxft'
  'libxt'
  'libxext'
  'libxmu'
  'perl'
  'startup-notification'
  'libnsl'
  'libptytty'
  'cvs'
)
_cvsurl=':pserver:anonymous@cvs.schmorp.de/schmorpforge'
_cvsmod='rxvt-unicode'
source=('urxvt.desktop'
        'urxvtc.desktop'
        'urxvt-tabbed.desktop')

prepare() {
  if [[ ! -d ${_cvsmod?} ]]; then
    cvs -z3 -d "${_cvsurl?}" checkout "${_cvsmod?}"
  else
    cd "${_cvsmod?}"
    cvs -z3 update -d -C -P
  fi
}

pkgver() {
  cd "${_cvsmod?}"

  (
    set -o pipefail
    # NB: "cvs log" prints UTC time.
    cvs -Q log -r -s Exp -S | grep -o '^date: [^;]*' | LC_ALL=C sort | tail -n 1 | cut -d ' ' -f 2-3 \
      | tr -d :- | tr ' ' .
  )
}

build() {
  cd "${_cvsmod?}"
  # we disable smart-resize (FS#34807)
  # do not specify --with-terminfo (FS#46424)
  # do not specify --disable-frills (FS#77474)
  # workaround ncurses --disable-root-access (FS#79143)
  export TIC="/usr/bin/tic -o${srcdir}/terminfo"
  ./configure \
    --prefix=/usr \
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
    --enable-pointer-blank \
    --enable-rxvt-scroll \
    --enable-selectionscrolling \
    --enable-slipwheeling \
    --disable-smart-resize \
    --enable-startup-notification \
    --enable-transparency \
    --enable-unicode3 \
    --enable-utmp \
    --enable-wtmp \
    --enable-xft \
    --enable-xim \
    --enable-xterm-scroll \
    --disable-pixbuf
  make
}

package_rxvt-unicode-cvs() {
  pkgdesc='Unicode enabled rxvt-clone terminal emulator (urxvt), CVS version'
  conflicts=(rxvt-unicode)
  provides=(rxvt-unicode)
  depends=(
    'rxvt-unicode-terminfo-cvs'
    'libxft'
    'perl'
    'startup-notification'
    'libnsl'
    'libptytty'
    'libxext'
    'libxmu'
  )
  optdepends=('gtk2-perl: to use urxvt-tabbed')

  # install freedesktop menu
  for _f in urxvt urxvtc urxvt-tabbed; do
    install -Dm 644 ${_f}.desktop "${pkgdir}/usr/share/applications/${_f}.desktop"
  done

  cd "${_cvsmod?}"
  make DESTDIR="${pkgdir}" install
  # install the tabbing wrapper ( requires gtk2-perl! )
  sed -i 's/\"rxvt\"/"urxvt"/' doc/rxvt-tabbed
  install -Dm 755 doc/rxvt-tabbed "${pkgdir}/usr/bin/urxvt-tabbed"
}

package_rxvt-unicode-terminfo-cvs() {
  pkgdesc='Terminfo files for urxvt, CVS version'
  conflicts=('rxvt-unicode<=9.18-6' 'rxvt-unicode-terminfo')
  provides=('rxvt-unicode-terminfo')
  install -dm 755 "${pkgdir}/usr/share/"
  mv terminfo "${pkgdir}/usr/share/"
}

sha256sums=('5f9c435d559371216d1c5b49c6ec44bfdb786b12d925d543c286b0764dea0319'
            '91536bb27c6504d6cb0d33775a0c4709a4b439670b900f0c278c25037f19ad66'
            'ccd7c436e959bdc9ab4f15801a67c695b382565b31d8c352254362e67412afcb')
