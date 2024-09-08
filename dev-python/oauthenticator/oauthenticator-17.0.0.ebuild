# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11,12} )

inherit distutils-r1 pypi

DESCRIPTION="OAuth + JupyterHub Authenticator = OAuthenticator "
HOMEPAGE="https://github.com/jupyterhub/oauthenticator/tree/main"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/jsonschema[${PYTHON_USEDEP}]
	>=dev-python/jupyterhub-2.2[${PYTHON_USEDEP}]
	>=dev-python/pyjwt-2[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/tornado[${PYTHON_USEDEP}]
	dev-python/traitlets[${PYTHON_USEDEP}]
"
