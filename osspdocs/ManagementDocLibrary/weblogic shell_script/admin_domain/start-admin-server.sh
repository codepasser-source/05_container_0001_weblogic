cd ./bin
pwd

echo "backup logs..."
mv ../logs/admin_server.out ../logs/admin_server`date +%Y-%m-%d-%H:%M:%S`.out
mv ../logs/admin_server.err ../logs/admin_server`date +%Y-%m-%d-%H:%M:%S`.err
mv ../logs/admin_server.gc.out ../logs/admin_server.gc`date +%Y-%m-%d-%H:%M:%S`.out

echo "set USER_MEM_ARGS..."
export USER_MEM_ARGS="-Xms512m -Xmx512m -XX:NewSize=256m -XX:MaxNewSize=256m -XX:MaxPermSize=512m -XX:+UseConcMarkSweepGC -XX:+HeapDumpOnOutOfMemoryError -verbose:gc -Xloggc:./logs/admin_server.gc.out -XX:+PrintGCDetails -XX:+PrintGCTimeStamps"

# ***********************************************************************************************************************
# remote debug java options
# JAVA_OPTIONS="-Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=7777,server=y,suspend=n"
# export JAVA_OPTIONS
# echo "remote debug mode is opened"
#########################################################################################################################


echo "start weblogic server for administrator server..."
nohup ./startWebLogic.sh 1> ../logs/admin_server.out 2> ../logs/admin_server.err &
tail -fn 50 ../logs/admin_server.out
