#/usr/bin/env bash

__texmf_home=$(kpsewhich -var-value=TEXMFHOME)
__latex="${__texmf_home}/tex/latex"
mkdir -p -v ${__latex}

packages=(
	beamerthemesmau
	beamerthemeuchicago
	beamerthemestanford
	beamerthemeduke
	beamerthemedesc
	beamerthemerubin
	beamerthemeroman
)

for package in "${packages[@]}"; do
	if [[ -L $__latex/$package ]]; then
		target=$(readlink -fv $package)
		printf "'%s' is '%s'\n" "$__latex/$package" "$target"
	else
		if [[ -d $__latex/$package && ! -L $__latex/$package ]]; then
			rm -irv "$__latex/$package"
		fi
		ln -sv "$PWD/tex/latex/$package" "$__latex/$package"
	fi
done
