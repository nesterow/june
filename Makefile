help:
	echo "> make build_mac \n> make help"

mac:
	ROOT_DIR=$(PWD) bash lib/build/mac.sh

run:
	julia -e "using Pkg; Pkg.activate(\"$(PWD)\"); include(\"src/main.jl\")"
