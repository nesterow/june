help:
	echo "> make build_mac \n> make help"

build_mac:
	ROOT_DIR=$(PWD) bash lib/build/mac.sh

run:
	julia -e "using Pkg; Pkg.activate(\"$(PWD)\"); include(\"src/main.jl\")"
