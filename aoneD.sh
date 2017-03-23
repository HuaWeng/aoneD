#!/bin/sh



ec_red(){
    printf  "\033[1;31m$@\033[0m\n"
}

ec_magenta(){
    printf  "\033[1;35m$@\033[0m\n"
}

die() {
    ec_red "$@"
    exit 1
}


apk_path=$1
if [ ${apk_path} = '' ];then
    die "No APK Path !!!"
fi

java -version  &>  /dev/null  2>&1 || die "Failed to Find Java !"

p=${apk_path##*/}
dir_name=${p%.*}
ec_magenta "dir name is $dir_name"
unzip ${apk_path}  -d ${dir_name} || die "Failed to unzip apk"

(
cd ${dir_name}
../dex2j.sh *.dex --force && java -jar ../jd-gui-1.4.0.jar  *.jar &> /dev/null 2>&1 &
)




