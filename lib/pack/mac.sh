echo ""
if [ -z "$APPNAME" ]
then
      export APPNAME=appname.app
      echo "-- APPNAME variable not found"
      echo "++ packaging <$APPNAME>"
else
      echo "++ packaging <$APPNAME>"
fi

export JULIA=$(ls /Applications/ | grep Julia | tail -1)
export JULIA_PACKAGE="/Applications/$JULIA"
export BUILD_DIR="$ROOT_DIR/dist"
export LOCAL_PACKAGE="$BUILD_DIR/$APPNAME"

echo "++ clean"
rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR

echo "++ copy julia package"
cp -r $JULIA_PACKAGE $BUILD_DIR/$APPNAME

echo "++ copy package contets"

export JLPKG=$LOCAL_PACKAGE/Contents/Resources/julia/local/share/julia/june
mkdir -p $JLPKG
cp $ROOT_DIR/Manifest.toml $JLPKG
cp $ROOT_DIR/Project.toml $JLPKG
cp -r $ROOT_DIR/src $JLPKG/src

echo "++ build dependencies"
export BREW=$(brew --prefix)
export QT_VERSION=$(ls $BREW/Cellar/qt/ | tail -1)
export QT_DIR="$BREW/Cellar/qt/$QT_VERSION"
export PATH="$PATH:$LOCAL_PACKAGE/Contents/Resources/julia/bin"
export JULIA_DEPOT_PATH=$LOCAL_PACKAGE/Contents/Resources/julia/local/share/julia

julia -e "using Pkg; Pkg.add(\"CxxWrap\")"
export JL_CXX_DIR="$(julia -e 'using CxxWrap; print(dirname(dirname(CxxWrap.libcxxwrap_julia)))')"

git clone https://github.com/barche/jlqml $JLPKG/jlqml
cd $JLPKG/jlqml
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH="$JL_CXX_DIR;$QT_DIR;$LOCAL_PACKAGE/Contents/Resources/julia" && make
export JLQML_DIR=$JLPKG/jlqml/build
julia -e "ENV[\"JLQML_DIR\"] = \"$JLQML_DIR\"; using Pkg; Pkg.activate(\"$JLPKG\"); Pkg.add(PackageSpec(url=\"https://github.com/barche/QML.jl\", rev=\"master\")); Pkg.build()"

echo "++ modifying startup script"
export STARTUP=$LOCAL_PACKAGE/Contents/Resources/julia/etc/julia/startup.jl
rm $STARTUP
cp $ROOT_DIR/lib/pack/startup.tmpl.jl $STARTUP

export APPLESCRIPT=$LOCAL_PACKAGE/Contents/Resources/Scripts/main.scpt
rm $APPLESCRIPT
cp $ROOT_DIR/lib/pack/main.scpt $APPLESCRIPT

echo "👍 Done!"
