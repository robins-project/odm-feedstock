#!/bin/bash

ln -s ${PREFIX} SuperBuild/install

mkdir build
cd build

export LDFLAGS="$LDFLAG -fuse-ld=gold -Wl,--no-as-needed"

#      -DOpenGL_GL_PREFERENCE=GLVND                    \
cmake -G "Ninja" \
      -DCMAKE_INSTALL_PREFIX=$PREFIX                  \
      -DCMAKE_PREFIX_PATH=$PREFIX                     \
      -DCMAKE_BUILD_TYPE:STRING=Release               \
      -DODM_BUILD_SLAM:BOOL=ON                        \
      -DBLA_VENDOR=Intel10_64lp                       \
      -DCMAKE_LIBRARY_ARCHITECTURE=x86_64-linux-gnu   \
      ..

ninja

# Install
cd ..

cp build/bin/* ${PREFIX}/bin

odm_dir=$SP_DIR/odm

mkdir -p $odm_dir
cp run.py $odm_dir
cp settings.yaml $odm_dir
cp VERSION $odm_dir

cp -R scripts $odm_dir
cp -R opendm $odm_dir

slam_dir=modules/odm_slam/src
mkdir -p $odm_dir/$slam_dir
cp $slam_dir/*.py $odm_dir/$slam_dir
