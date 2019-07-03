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
    select_compiler
    cmake -G "Unix Makefiles" -DZMQ_BUILD_TESTS=OFF -DCMAKE_BUILD_TYPE=Release ../
    make -j30;make
    cd -
}
function deploy() {
    source_dir=$1
    deploy=$2
    cp $source_dir/include/*h -a $deploy
    if [[ ! -d $deploy/bin ]];then
        mkdir $deploy/bin
    fi
    cp $source_dir/build/bin/* $deploy/bin/

    if [[ ! -d $deploy/lib64_release ]];then
        mkdir $deploy/lib64_release
    fi
    cp $source_dir/build/lib/* $deploy/lib64_release
}
source_dir=$1
cmake_build $source_dir
if [[ $? -eq 0 ]];then
    deploy $source_dir $(pwd)
fi