pkgname=ci-utils
pkgver=1.0.0
pkgrel=1
arch=('any')
depends=('bash')
makedepends=('git')
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
