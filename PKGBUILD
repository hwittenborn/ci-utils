# Maintainer: Hunter Wittenborn <hunter@hunterwittenborn.com>
pkgname=ci-utils
pkgver=1.0.4
pkgrel=1
pkgdesc="Various utilities for use in CI systems"
arch=('any')
depends=('bash' 'openssh-client' 'findutils' 'gawk' 'grep')
license=('GPL3')
url='https://github.com/hwittenborn/ci-utils'

_repodir="$(git rev-parse --show-toplevel)"
source=("ci-utils::git+file://${_repodir}")
sha256sums=('SKIP')

package() {
    cd ci-utils/src/
    find ./ -maxdepth 1 -type f -exec sed -i 's|.*# REMOVE AT PACKAGING$||' '{}' +
    find ./ -maxdepth 1 -type f -exec install -Dm 755 '{}' "${pkgdir}/usr/local/bin/{}" \;
}
