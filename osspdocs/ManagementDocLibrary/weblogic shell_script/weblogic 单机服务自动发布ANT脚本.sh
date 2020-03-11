#!/bin/sh

D="union"
CONTENT_FOLDER="union"
WAR="taiping-sol-insu-union.war"
SRC_TMP_PATH="/tpdata/weblogic/temp"
DIST_PATH="/tpdata/Oracle/Middleware/user_projects/domains/$D"

echo ============= deploy [$D] start ... ===========
echo SRC_TMP_PATH: $SRC_TMP_PATH
echo DIST_PATH: $DIST_PATH

echo -e '\n'
echo publish content ...
cd $SRC_TMP_PATH
rm -rf $CONTENT_FOLDER
unzip $WAR -d $CONTENT_FOLDER
rm -rf $CONTENT_FOLDER/$WAR
rm -rf $CONTENT_FOLDER/WEB-INF
rm -rf $CONTENT_FOLDER/META-INF

echo -e '\n'
echo stop weblogic ...

cd $DIST_PATH/bin
./stopWebLogic.sh

echo -e '\n'
echo clean data ...

rm -rf $DIST_PATH/servers/AdminServer/tmp
\cp -R -f $DIST_PATH/servers/AdminServer/upload/$WAR /tpdata/weblogic/backup/

rm -rf $DIST_PATH/servers/AdminServer/upload
mkdir $DIST_PATH/servers/AdminServer/tmp
mkdir $DIST_PATH/servers/AdminServer/upload

echo -e '\n'
echo copy war to deploy ...
mkdir $DIST_PATH/servers/AdminServer/upload/taiping-sol-insu-union
unzip $SRC_TMP_PATH/$WAR -d $DIST_PATH/servers/AdminServer/upload/taiping-sol-insu-union
#\cp -R -f $SRC_TMP_PATH/$WAR $DIST_PATH/servers/AdminServer/upload/

echo -e '\n'
echo restart weblogic ...
cd ..
nohup ./startWebLogic.sh > out.log 2>&1 &

echo -e '\n'
echo ============= deploy [$D] finish ... ===========

tail -f out.log
