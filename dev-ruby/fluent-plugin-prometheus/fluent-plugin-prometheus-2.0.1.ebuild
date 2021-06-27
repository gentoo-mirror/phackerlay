# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
USE_RUBY="ruby25 ruby26 ruby27"

#RUBY_FAKEGEM_EXTRADOC="Changelog README.md"

#RUBY_FAKEGEM_RECIPE_TEST="rspec3"

inherit ruby-fakegem

DESCRIPTION="A fluent plugin that collects metrics and exposes for Prometheus."
HOMEPAGE="https://github.com/fluent/fluent-plugin-prometheus/"
LICENSE="Apache-2.0"

KEYWORDS="~amd64"
SLOT="0"
IUSE=""

RDEPEND="
	>=dev-ruby/prometheus-client-2.1.0
	>=app-admin/fluentd-1.9.1
	<app-admin/fluentd-2
"

#ruby_add_rdepend ">=dev-ruby/sigdump-0.2.2:0"

#ruby_add_bdepend "test? ( dev-ruby/bundler )"

#all_ruby_prepare() {
#	sed -i -e '/rake/ s/~>/>=/' \
#		-e '/rspec/ s/2.13.0/2.13/' \
#		-e '/rake-compiler/ s:^:#:' serverengine.gemspec || die
#}

#each_ruby_test() {
#	# The specs spawn ruby processes with bundler support
#	${RUBY} -S bundle exec rspec-2 spec || die
#}
