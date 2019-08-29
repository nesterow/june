help:
	echo "> make mac \n>make pack-mac \n> make help"

mac:
	ROOT_DIR=$(PWD) bash lib/build/mac.sh

pack-mac:
	ROOT_DIR=$(PWD) bash lib/pack/mac.sh

run:
	julia -e "using Pkg; Pkg.activate(\"$(PWD)\"); include(\"src/main.jl\")"
