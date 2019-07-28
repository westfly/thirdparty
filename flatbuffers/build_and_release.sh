function select_compiler() {
 #https://stackoverflow.com/questions/17275348/how-to-specify-new-gcc-path-for-cmake
 devtool=/opt/rh/devtoolset-7/root/usr/
 export CC=$devtool/bin/gcc
 export CXX=$devtool/bin/g++
}
function cmake_build() {
    source_dir=$1
    select_compiler
    build=$source_dir/build
    if [[ ! -d $build ]];then
        mkdir $build
    fi
    cd $build
    if [[ 0 -eq 1 ]];then
        cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release ../
        make -j3;make
    else
        cmake3 -G "Ninja" -DCMAKE_BUILD_TYPE=Release ../
        ninja
    fi
    cd -
}
function deploy() {
    source_dir=$1
    deploy=$2
    cp $source_dir/include/flatbuffers/* -a $deploy
    if [[ ! -d $deploy/bin ]];then
        mkdir $deploy/bin
    fi
    cp $source_dir/build/flat* $deploy/bin/
    if [[ ! -d $deploy/lib64_release ]];then
        mkdir $deploy/lib64_release
    fi
    cp $source_dir/build/lib*a $deploy/lib64_release
}
source_dir=$1
cmake_build $source_dir
if [[ $? -eq 0 ]];then
    deploy $source_dir $(pwd)
fi
