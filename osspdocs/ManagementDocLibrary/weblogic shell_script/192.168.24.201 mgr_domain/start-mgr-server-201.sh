cd ./bin
pwd

echo "backup logs..."
mv ../logs/mgr_server_201.out ../logs/mgr_server_201`date +%Y-%m-%d-%H:%M:%S`.out
mv ../logs/mgr_server_201.err ../logs/mgr_server_201`date +%Y-%m-%d-%H:%M:%S`.err
mv ../logs/mgr_server_201.gc.out ../logs/mgr_server_201.gc`date +%Y-%m-%d-%H:%M:%S`.out

echo "set USER_MEM_ARGS..."
export USER_MEM_ARGS="-Xms512m -Xmx512m -XX:NewSize=256m -XX:MaxNewSize=256m -XX:MaxPermSize=512m -XX:+UseConcMarkSweepGC -XX:+HeapDumpOnOutOfMemoryError -verbose:gc -Xloggc:./logs/mgr_server_201.gc.out -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -Dweblogic.threadpool.MinPoolSize=100 -Dweblogic.threadpool.MaxPoolSize=300"

# ***********************************************************************************************************************
# remote debug java options
# JAVA_OPTIONS="-Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=7777,server=y,suspend=n"
# export JAVA_OPTIONS
# echo "remote debug mode is opened"
#########################################################################################################################


echo "start weblogic server for mgr-server-201..."
nohup ./startManagedWebLogic.sh mgr-server-201 t3://192.168.24.201:7001 1> ../logs/mgr_server_201.out 2> ../logs/mgr_server_201.err &
tail -fn 50 ../logs/mgr_server_201.out
