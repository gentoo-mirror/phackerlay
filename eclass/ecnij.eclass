# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: eclass/ecnij.eclass,v 4.2 2018/08/22 19:33:34 Exp $

# Fixed repeated setup & configuration of same directories
# Fixed wrong arguments to econf
# Fixed wrong DESTDIR argument to emake install
# Fixed most binaries were not installed
#	-Ted. 2020-07-02

# @ECLASS: ecnij.eclass
# @MAINTAINER:
# bar-overlay <bar-overlay@noreply.github.com>
# @AUTHOR:
# Original author: tokiclover <tokiclover@gmail.com>
# @BLURB: Provide a set of functions to get CUPS backends, filters and utilities
# for Canon(R) Pixma/Pixus printer series
# @DESCRIPTION:
# Exports base functions used by ebuilds written
# for net-print/cnijfilter package for canon(r) hardware

if [[ -z "${_ECNIJ_ECLASS}" ]]; then
_ECNIJ_ECLASS=1

inherit autotools flag-o-matic multilib-build
#eutils

# @ECLASS-VARIABLE: PRINTER_MODEL
# @DESCRIPTION:
# Array of printer models supported by the ebuild
# PRINTER_MODEL=(ip90 ip100)
:	${PRINTER_MODEL:=}

# @ECLASS-VARIABLE: PRINTER_ID
# @DESCRIPTION:
# Array of printer ID supported by the ebuild (complement of PRINTER_MODEL)
# PRINTER_ID=(303 253)
:	${PRINTER_ID:=}

IUSE="${IUSE} +cups debug servicetools ${PRINTER_MODEL[@]/#/canon_printers_}"
KEYWORDS="~x86 ~amd64"

REQUIRED_USE="${REQUIRED_USE}
	|| ( cups ${PRINTER_MODEL[@]/#/canon_printers_} )"
if (( ${PV:0:1} > 3 )) || ( (( ${PV:0:1} == 3 )) && (( ${PV:2:2} >= 10 )) ); then
IUSE="${IUSE} +net +usb"
REQUIRED_USE="${REQUIRED_USE}
	servicetools? ( net ) cups? ( || ( net usb ) )"
SLOT="3/${PV}"
else
SLOT="2/${PV}"
fi

LICENSE="GPL-2"
has net ${IUSE} && LICENSE+=" net? ( CNIJFILTER )"

RDEPEND="${RDEPEND}
	>=net-print/cups-1.6.0[${MULTILIB_USEDEP}]
	app-text/ghostscript-gpl
	dev-libs/glib[${MULTILIB_USEDEP}]
	dev-libs/popt[${MULTILIB_USEDEP}]
	media-libs/tiff[${MULTILIB_USEDEP}]
	media-libs/libpng[${MULTILIB_USEDEP}]
	!cups? ( >=${CATEGORY}/${P}[${MULTILIB_USEDEP},cups] )"

if (( ${PV:0:1} == 3 )) || ( (( ${PV:0:1} == 2 )) && (( ${PV:2:2} >= 80 )) ); then
RDEPEND="${RDEPEND}
	servicetools? (
		dev-libs/libxml2[${MULTILIB_USEDEP}]
		gnome-base/libglade[${MULTILIB_USEDEP}]
		x11-libs/gtk+:2[${MULTILIB_USEDEP}]
	)"
elif (( ${PV:0:1} == 2 )); then
RDEPEND="${RDEPEND}
	servicetools? (
		dev-libs/libxml2[${MULTILIB_USEDEP}]
		gnome-base/libglade[${MULTILIB_USEDEP}]
		x11-libs/gtk+:2[${MULTILIB_USEDEP}]
	)"
fi
DEPEND="${DEPEND}
	virtual/libintl"

:	${EAPI:=8}
[[ ${EAPI} -lt 4 ]] && die "EAPI=\"${EAPI}\" is not supported"

EXPORT_FUNCTIONS pkg_setup src_unpack src_prepare src_configure src_compile src_install pkg_postinst

# @FUNCTION: dir_src_prepare
# @DESCRIPTION:
# Internal wrapper to handle subdir phase {prepare,config,compilation...}
dir_src_command()
{
	debug-print-function ${FUNCNAME} "${@}"
	(( $# < 1 )) && die "Invalid number of argument"

	for dir in "${DIRS[@]}"; do
		local -a myeconfargs=()

		echo $dir
		pushd ${dir} || die
		case "${1}" in
			(eautoreconf)
			[[ -d po ]] && echo "no" | glib-gettextize --force --copy
			[[ ! -e configure.in ]] && [[ -e configures/configure.in.new ]] &&
				mv -f configures/configure.in.new configure.in
#blaster /home/ustinov # cd /var/tmp/portage/net-print/cnijfilter-4.10/work/cnijfilter-4.10/ix6800/bscc2sts/
#blaster /var/tmp/portage/net-print/cnijfilter-4.10/work/cnijfilter-4.10/ix6800/bscc2sts # mv configure.ac configure.in
#blaster /var/tmp/portage/net-print/cnijfilter-4.10/work/cnijfilter-4.10/ix6800/bscc2sts # cd ../cnijfilter/
#blaster /var/tmp/portage/net-print/cnijfilter-4.10/work/cnijfilter-4.10/ix6800/cnijfilter # mv configure.ac configure.in
			"${@}"
			;;
			(econf)
			[[ ! -e configure.in ]] && [[ -e configure.ac ]] &&
				mv -f configure.ac configure.in
			case ${dir} in
				(backendnet|lgmon2)
					myeconfargs=(
						"--enable-progpath=/usr/bin"
						"--enable-libpath=/var/lib/cnijlib"
					)
				;;
				(backend|cngpij|cngpiji*|cngpijmon|cnijbe|lgmon|pstocanonij)
					myeconfargs=(
						"--enable-progpath=/usr/bin"
					)
				;;
				(cngpijmon/cnijnpr|cnijfilter|printui)
					myeconfargs=(
						"--enable-libpath=/var/lib/cnijlib"
					)
				;;
			esac
			"${@}" "${myeconfargs[@]}"
			;;
			(*)
			"${@}"
			;;
		esac
		popd || die
	done
}

# @FUNCTION: ecnij_pkg_setup
# @DESCRIPTION:
# Default exported pkg_setup() function
ecnij_pkg_setup()
{

	debug-print-function ${FUNCNAME} "${@}"

	[[ "${LINGUAS}" ]] || export LINGUAS="en"

	use abi_x86_32 && use amd64 && multilib_toolchain_setup "x86"

	CNIJFILTER_SRC=( libs pstocanonij )
	PRINTER_SRC=( cnijfilter )
	# use_if_iuse usb && CNIJFILTER_SRC+=( backend )
	# use_if_iuse net && CNIJFILTER_SRC+=( backendnet )
	# if ! has usb  && ! use_if_iuse usb ; then
	#	(( ${PV:0:1} >= 3 )) || ( (( ${PV:0:1} == 2 )) && (( ${PV:2:2} >= 80 )) ) &&
	#		CNIJFILTER_SRC+=( backend )
	#fi
	CNIJFILTER_SRC+=( cngpij )
	if (( ${PV:0:1} == 4 )); then
		PRINTER_SRC+=( lgmon2 )
		# use_if_iuse net && PRINTER_SRC+=( cnijnpr )
	else
		PRINTER_SRC+=( lgmon cngpijmon )
		# use_if_iuse net && PRINTER_SRC+=( cngpijmon/cnijnpr )
	fi

	if use servicetools; then
	if (( ${PV:0:1} == 4 )); then
		CNIJFILTER_SRC+=( cngpijmnt )
	elif (( ${PV:0:1} == 3 )) && (( ${PV:2:2} >= 80 )); then
		CNIJFILTER_SRC+=( cngpijmnt maintenance )
	else
		PRINTER_SRC+=( printui )
	fi
	fi

	if (( ${PV:0:1} == 4 )); then
		PRINTER_SRC=( bscc2sts "${PRINTER_SRC[@]}" )
		CNIJFILTER_SRC=( cmdtocanonij "${CNIJFILTER_SRC[@]}" cnijbe )
	fi
}

# @FUNCTION: ecnij_src_unpack
# @DESCRIPTION:
# Default exported src_unpack() function
ecnij_src_unpack()
{
	debug-print-function ${FUNCNAME} "${@}"

	default
	mv ${PN}-* ${P} || die "Failed to unpack"
	cd "${S}"
}

# @FUNCTION: ecnij_src_prepare
# @DESCRIPTION:
# Setup environment and run elibtoolize;
# Default exported src_prepare() function supporting PATCHES
ecnij_src_prepare()
{
	debug-print-function ${FUNCNAME} "${@}"
	local -a DIRS=()

	[[ "${PATCHES}" ]] && eapply "${PATCHES[@]}"
	eapply_user

	find -iname "configure.in" | xargs sed -i -e 's/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/g'
	find -iname "configure.in" | xargs sed -i -e 's/AM_PROG_CC_STDC/AC_PROG_CC/g'

	local p pr prid
	for (( p=0; p<${#PRINTER_ID[@]}; p++ )); do
		pr=${PRINTER_MODEL[$p]} prid=${PRINTER_ID[$p]}
		if use canon_printers_${pr}; then
			mkdir ${pr} || die
			cp -a ${prid} "${PRINTER_SRC[@]}" ${pr} || die "Failed to copy source files"

			pushd ${pr} || die
			[[ -d ../com ]] && ln -s {../,}com
			DIRS=("${PRINTER_SRC[@]}")
			dir_src_command "eautoreconf"
			popd
		fi
	done

	DIRS=("${CNIJFILTER_SRC[@]}")
	use cups && dir_src_command "eautoreconf"
}

# @FUNCTION: ecnij_src_configure
# @DESCRIPTION:
# Deafult exported src_configure() function
ecnij_src_configure()
{
	debug-print-function ${FUNCNAME} "${@}"
	local -a DIRS=( )

	local p pr prid
	for (( p=0; p<${#PRINTER_ID[@]}; p++ )); do
		pr=${PRINTER_MODEL[$p]} prid=${PRINTER_ID[$p]}
		if use canon_printers_${pr}; then
			pushd ${pr} || die
			DIRS=("${PRINTER_SRC[@]}")
			dir_src_command "econf" "--program-suffix=${pr}"
			popd
		fi
	done

	DIRS=("${CNIJFILTER_SRC[@]}")
	use cups && dir_src_command "econf"
}

# @FUNCTION: ecnij_src_compile
# @DESCRIPTION:
# The base exported src_compile() function
ecnij_src_compile() {
	debug-print-function ${FUNCNAME} "${@}"
	local -a DIRS=( )

	local p pr prid
	for (( p=0; p<${#PRINTER_ID[@]}; p++ )); do
		pr=${PRINTER_MODEL[$p]} prid=${PRINTER_ID[$p]}
		if use canon_printers_${pr}; then
			pushd ${pr} || die
			DIRS=("${PRINTER_SRC[@]}")
			dir_src_command "emake"
			popd
		fi
	done

	DIRS=("${CNIJFILTER_SRC[@]}")
	use cups && dir_src_command "emake"
}

# @FUNCTION: ecnij_src_install
# @DESCRIPTION:
# Default exported src_install() function
ecnij_src_install()
{
	debug-print-function ${FUNCNAME} "${@}"
	local -a DIRS=( )

	local abi_libdir=/usr/$(get_libdir) p pr prid
	local abi_lib=$(usex abi_x86_64 64 32)
	local lib license lingua=false
	local -a DOCS

	(( ${#MULTILIB_COMPAT[@]} == 1 )) && abi_lib=

	DIRS=("${CNIJFILTER_SRC[@]}")
	use cups && dir_src_command "emake" "DESTDIR=${D}" "install"

	for (( p=0; p<${#PRINTER_ID[@]}; p++ )); do
		pr=${PRINTER_MODEL[$p]} prid=${PRINTER_ID[$p]}
		if use canon_printers_${pr}; then
			lingua=true
			pushd ${pr} || die
			DIRS=("${PRINTER_SRC[@]}")
			dir_src_command "emake" "DESTDIR=${D}" "install"
			popd

			pushd ${prid}/libs_bin${abi_lib} || die
			for lib in lib*.so; do
				[[ -L ${lib} ]] && continue ||
				rm ${lib} && ln -s ${lib}.[0-9]* ${lib}
			done
			popd

			dolib.so ${prid}/libs_bin${abi_lib}/*.so*
			exeinto /var/lib/cnijlib
			doexe ${prid}/database/*
			insinto /usr/share/cups/model
			doins ppd/canon${pr}.ppd

			# if use_if_iuse doc; then
			# for lingua in ${LINGUAS}; do
			#	lingua="${lingua^^[a-z]}"
			#	[[ -f lproptions/lproptions-${pr}-${PV}${lingua}.txt ]] &&
			#	DOCS+=(lproptions/lproptions-${pr}-${PV}${lingua}.txt)
			# done
			# fi
		fi
	done

	#if use cups && use_if_iuse net; then
	#	pushd com/libs_bin${abi_lib} || die
	#	for lib in lib*.so; do
	#		[[ -L ${lib} ]] && continue ||
	#		rm ${lib} && ln -s ${lib}.[0-9]* ${lib}
	#	done
	#	popd

	#	dolib.so com/libs_bin${abi_lib}/*.so*
	#	EXEOPTIONS="-m555 -glp -olp"
	#	exeinto /var/lib/cnijlib
	#	doexe com/ini/cnnet.ini
	#fi

	if use cups && (( ${PV:0:1} == 4 )); then
		mkdir -p "${ED}"/usr/share/${PN} || die
		mv "${ED}"/usr/share/{cmdtocanonij,${PN}} || die
	fi

	#if ${lingua} || use_if_iuse net; then
	#for lingua in ${LINGUAS}; do
	#	lingua="${lingua^^[a-z]}"
	#	license=LICENSE-${PN}-${PV}${lingua}.txt
	#	[[ -e ${license%${lingua:0:1}.txt}.txt ]] &&
	#	mv -f ${license%{lingua:0:1}.txt} ${license}
	#	[[ -e ${license} ]] && DOCS+=(${license})
	#done
	#fi

	[[ "${DOCS[*]}" ]] && dodoc "${DOCS[@]}"
}

# @FUNCTION: ecnij_pkg_postinst
# @DESCRIPTION:
# Default exported src_postinst() function
ecnij_pkg_postinst()
{
	debug-print-function ${FUNCNAME} "${@}"

	# XXX: set up ppd files to use newer CUPS backends
	if (( ${PV:0:1} < 3 )) || ( (( ${PV:0:1} == 3 )) && (( ${PV:2:1} == 0 )) ); then
		use cups || sed 's,cnij_usb,cnijusb,g' -i "${ED}"/usr/share/cups/model/canon*.ppd
	fi

	elog "To install a printer:"
	elog " * First, restart CUPS: 'service cupsd restart'"
	elog " * Go to http://127.0.0.1:631/ with your favorite browser"
	elog "   and then go to Printers/Add Printer"
	elog
	elog "You can consult the following for any issue/bug:"
	elog
#	elog "${FILESDIR%/*}/README.md"
	elog "https://forums.gentoo.org/viewtopic-p-3217721.html"
	elog "https://bugs.gentoo.org/show_bug.cgi?id=130645"
}

fi
