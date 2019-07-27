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
    if [[ -f CMakeCache.txt ]];then
        rm CMakeCache.txt
    fi
    cmake3 -DCMAKE_INSTALL_PREFIX=../release -DCMAKE_BUILD_TYPE=Release ../
    make -j30;make
    make install
    cd -
}
function make_single_lib() {
	deploy_lib=$1
	mkdir /tmp/abseil
	cd /tmp/abseil
	ls $deploy_lib/libabsl_*.a | xargs -n1 ar x  # 批量解压
	ar cru libabseil.a *.o   # 打包成单一的库
	ranlib libabseil.a  
	cp libabseil.a $deploy_lib
	cd -
}
function deploy() {
    source_dir=$1/release
    deploy=$2
    cp $source_dir/include/absl/* -a $deploy
    cp $source_dir/lib64/* -a $deploy/lib64_release
	make_single_lib $deploy/lib64_release
}
source_dir=$1
cmake_build $source_dir
if [[ $? -eq 0 ]];then
    deploy $source_dir $(pwd)
fi
