function select_compiler() {
 #https://stackoverflow.com/questions/17275348/how-to-specify-new-gcc-path-for-cmake
 devtool=/opt/rh/devtoolset-7/root/usr/
 export CC=$devtool/bin/gcc
 export CXX=$devtool/bin/g++
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
                        -DBUILD_TESTING=ON      \
                        ..
        ninja
    fi
    cd -
}
function deploy() {
    source_dir=$1
    deploy=$2
    package=$(echo $source_dir | awk -F'/' '{print $(NF-1)}')
    cp $source_dir/$package/*h -a $deploy
    if [[ ! -d $deploy/bin ]];then
        mkdir $deploy/bin
    fi
    cp $source_dir/build/bin/* $deploy/bin/

    if [[ ! -d $deploy/lib64_release ]];then
        mkdir $deploy/lib64_release
    fi
    cp $source_dir/build/lib$package.a $deploy/lib64_release
}
source_dir=$1
cmake_build $source_dir
if [[ $? -eq 0 ]];then
    deploy $source_dir $(pwd)
fi
