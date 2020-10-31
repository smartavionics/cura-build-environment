#! /bin/sh

if test "$(uname)" = "Darwin"; then
  export CURA_TARGET_OSX_VERSION=10.13
  . ../env_osx.sh
  if [[ -e /Library/Developer/CommandLineTools/usr/bin/clang ]]; then
    export CC="/Library/Developer/CommandLineTools/usr/bin/clang"
    export CXX="/Library/Developer/CommandLineTools/usr/bin/clang++"
  fi
  export CURA_HOME=~/cura/local
  mkdir $CURA_HOME
else
  export CURA_HOME=/opt/cura
fi

PATH=$CURA_HOME/bin/:$PATH cmake \
  -DCMAKE_PREFIX_PATH=$CURA_HOME \
  -DCMAKE_INSTALL_PREFIX=$CURA_HOME \
  -DCURA_SAVITAR_BRANCH_OR_TAG=sip5 \
  ..

