rm -rf lib/jlqml

export BREW=$(brew --prefix)
export QT_VERSION=$(ls $BREW/Cellar/qt/ | tail -1)
export JL_VERSION=$(ls /Applications/ | grep Julia | tail -1)
export JL_PATH="/Applications/$JL_VERSION/Contents/Resources/julia/"
export PATH="$PATH:$JL_PATH/bin"

julia -e "using Pkg; Pkg.activate(\"$ROOT_DIR\"); Pkg.add(\"CxxWrap\")"

export JL_CXX_DIR="$(julia -e 'using CxxWrap; print(dirname(dirname(CxxWrap.libcxxwrap_julia)))')"
export QT_DIR="$BREW/Cellar/qt/$QT_VERSION"

git clone https://github.com/barche/jlqml lib/jlqml
cd lib/jlqml
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH="$JL_CXX_DIR;$QT_DIR;$JL_PATH" && make

cd $ROOT_DIR
export JLQML_DIR="$ROOT_DIR/lib/jlqml/build"

julia -e "using Pkg; Pkg.activate(\"$ROOT_DIR\"); Pkg.add(PackageSpec(url=\"https://github.com/barche/QML.jl\", rev=\"master\")); Pkg.build()"
echo "🏁 Everything is ready!"
