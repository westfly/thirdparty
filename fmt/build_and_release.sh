function select_compiler() {
 #https://stackoverflow.com/questions/17275348/how-to-specify-new-gcc-path-for-cmake
 devtool=/opt/rh/devtoolset-8/root/usr/
 if [[ -d $devtool ]]; then
     export CC=$devtool/bin/gcc
     export CXX=$devtool/bin/g++
 fi
}
function cmake_build() {
    source_dir=$1
    build=$source_dir/build
    if [[ ! -d $build ]];then
        mkdir $build
    fi
    cd $build
	if [[ -f CMakeCache.txt ]];then
        rm CMakeCache.txt
    fi
    select_compiler
    if [[ 0 -eq 0 ]];then
        cmake3 -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo \
                        -DBUILD_SHARED_LIBS=OFF \
                        -DFMT_TEST=OFF \
                        -DFMT_DOC=OFF \
                        ..
        ninja
    fi
    cd -
}
function deploy() {
    source_dir=$1
    deploy=$2
    cp $source_dir/include/fmt/*h -a $deploy
    if [[ ! -d $deploy/bin ]];then
        mkdir $deploy/bin
    fi
    #cp $source_dir/build/bin/* $deploy/bin/

    if [[ ! -d $deploy/lib64_release ]];then
        mkdir $deploy/lib64_release
    fi
    cp $source_dir/build/libfmt.a $deploy/lib64_release
}
source_dir=$1
cmake_build $source_dir
if [[ $? -eq 0 ]];then
    deploy $source_dir $(pwd)
fi
