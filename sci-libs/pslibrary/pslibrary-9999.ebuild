# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A collection of input files for the ld1.x atomic code which is distributed with the Quantum ESPRESSO package.  It allows the generation of PAW data-sets or US pseudopotentials, scalar relativistic or fully relativistic, for several elements."
HOMEPAGE="https://dalcorso.github.io/pslibrary/"

inherit autotools git-r3

EGIT_REPO_URI="https://github.com/dalcorso/pslibrary.git"
EGIT_BRANCH="master"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"
IUSE="H He Li Be B +C +N +O F Ne Na Mg +Al +Si P S Cl Ar K Ca \
Sc Ti V Cr Mn +Fe +Co +Ni +Cu Zn +Ga Ge +As Se +Br Kr Rb Sr Y Zr \
Nb +Mo Tc Ru Rh Pd +Ag Cd In Sn Sb Te I Xe +Cs Ba La Ce Pr Nd \
Pm Sm Eu Gd Tb Dy Ho Er Tm Yb Lu Hf Ta W Re Os Ir Pt Au Hg \
Tl Pb Bi Po At Rn Fr Ra Ac Th Pa U Np Pu"

RDEPEND=""
BDEPEND="sci-physics/quantum-espresso"

src_unpack() {
	git-r3_fetch
	git-r3_checkout
}

src_configure() {
	ELEMENTS="$(usev H) $(usev He) $(usev Li) $(usev Be) $(usev B) \
 $(usev C) $(usev N) $(usev O) $(usev F) $(usev Ne) $(usev Na) \
$(usev Mg) $(usev Al) $(usev Si) $(usev P) $(usev S) $(usev Cl) \
$(usev Ar) $(usev K) $(usev Ca) $(usev Sc) $(usev Ti) $(usev V) \
$(usev Cr) $(usev Mn) $(usev Fe) $(usev Co) $(usev Ni) $(usev Cu) \
$(usev Zn) $(usev Ga) $(usev Ge) $(usev As) $(usev Se) $(usev Br) \
$(usev Kr) $(usev Rb) $(usev Sr) $(usev Y) $(usev Zr) $(usev Nb) \
$(usev Mo) $(usev Tc) $(usev Ru) $(usev Rh) $(usev Pd) $(usev Ag) \
$(usev Cd) $(usev In) $(usev Sn) $(usev Sb) $(usev Te) $(usev I) \
$(usev Xe) $(usev Cs) $(usev Ba) $(usev La) $(usev Ce) $(usev Pr) \
$(usev Nd) $(usev Pm) $(usev Sm) $(usev Eu) $(usev Gd) $(usev Tb) \
$(usev Dy) $(usev Ho) $(usev Er) $(usev Tm) $(usev Yb) $(usev Lu) \
$(usev Hf) $(usev Ta) $(usev W) $(usev Re) $(usev Os) $(usev Ir) \
$(usev Pt) $(usev Au) $(usev Hg) $(usev Tl) $(usev Pb) $(usev Bi) \
$(usev Po) $(usev At) $(usev Rn) $(usev Fr) $(usev Ra) $(usev Ac) \
$(usev Th) $(usev Pa) $(usev U) $(usev Np) $(usev Pu)"
	einfo
	einfo Building pseudopotentials "for" $ELEMENTS
	einfo Alter USE "if" that is not your intent
	einfo
	sed -e "s:element='all':element=\"${ELEMENTS}\":g" -i make_ps || die
	sed -e 's:echo "ld:# echo "ld:g' -i make_ps || die
	sed -e 's:. $PWDIR/environment_variables::g' -i make_ps || die
	sed -e 's:mv *.UPF PSEUDOPOTENTIALS::g' -i make_ps || die
	sed -e 's:mv *.in WORK::g' -i make_ps || die
	sed -e 's:"$elem":"$elem.":g' -i make_ps || die
	sed -e "s:/path_to_quantum_espresso:/usr:g" -i QE_path || die
}

src_compile() {
	addpredict /proc/mtrr
	num=0
	for cpu in $(cat /proc/cpuinfo | grep processor | cut -d" " -f2);
		do
		addpredict /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_governor
		let num=$num+1
	done
	PARA_POSTFIX=""
	if ! has_version sci-physics/quantum-espresso[openmp] && has_version sci-physics/quantum-espresso[mpi];
		then
		PARA_PREFIX="mpirun -n $num"
	else
		PARA_PREFIX=""
	fi
	. ./make_all_ps

}


src_install() {
	pseudopath=/usr/share/quantum-espresso/pseudo
	mkdir -p ${D}$pseudopath 
	find . -type f -name '*.UPF' -exec install '{}' ${D}/usr/share/quantum-espresso/pseudo/ \; 
}

pkg_postinst() {
	einfo
	einfo "All generated pseudopotentials lie in ${pseudopath}/ "
	einfo
}
