#!/bin/sh 

bin="${BASH_SOURCE-$0}"
bin=`dirname ${bin}`
bin=`cd ${bin}; pwd`

#JDK所在路径 
JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_144.jdk/Contents/Home"    




#######*****   修改java home 路径





#Java程序所在的目录（classes的上一级目录） 
APP_HOME="/Users/liben/Workspaces/MyEclipse2017CI/rtt"

#######*****   修改app home 路径



APP_HOME="$bin/.."

#需要启动的Java主程序（main方法类） 
APP_MAINCLASS="com.rtt.test.TestServer"


#######*****   如果需要修改   main class 




APP_JAR="$bin/../rtt.jar"



#######*****   如果需要修改   jar 包名


#拼凑完整的classpath参数，包括指定lib目录下所有的jar 
#CLASSPATH="." 
#for i in ../lib/*.jar; do 
#    CLASSPATH="$CLASSPATH":"$i" 
#done
#echo $CLASSPATH

#执行程序启动所使用的系统用户，考虑到安全，推荐不使用root帐号 
RUNNING_USER=liben

#java虚拟机启动参数 

pid=0 
checkpid() {
#    javaps=`$JAVA_HOME/bin/jps -l | grep adp.jar` 
    javaps=`ps -ef | grep TestServer | grep rtt | grep -v grep | awk '{print $2}'` 
    if [ -n "$javaps" ]; then 
        pid=$javaps 
    else 
        pid=0 
    fi  
} 

start() {
    checkpid
    if [ $pid -ne 0 ]; then 
        echo "======================================================" 
        echo "===warn: rtt.jar already started! (pid=$pid)===" 
        echo "======================================================" 
    else 
        echo -n "Starting rtt.jar now..." 
        #JAVA_CMD="nohup java -classpath $CLASSPATH $APP_MAINCLASS >/dev/null 2>&1 &" 
        nohup java -Xmx8192m  -XX:-UseGCOverheadLimit  -jar $APP_JAR $APP_MAINCLASS >./nohup.out 2>&1 & 
        
        
        #######*****   注意此处的参数  -Xmx8192m  -XX:-UseGCOverheadLimit   修改堆大小
        
        
        
        
        #su - $RUNNING_USER -c "$JAVA_CMD"
        checkpid 
        if [ $pid -ne 0 ]; then 
            echo "Start rtt.jar (pid=$pid) [OK]" 
        else 
            echo "Start rtt.jar [Failed]" 
        fi 
    fi 
} 

stop() { 
    checkpid
    if [ $pid -ne 0 ]; then 
        echo -n "Stopping rtt.jar ...(pid=$pid) " 
        kill -9 $pid 
        #su - $RUNNING_USER -c "kill -9 $pid" 
        if [ $? -eq 0 ]; then 
            echo "Stop rtt.jar [OK]" 
        else 
            echo "Stop rtt.jar [Failed]" 
        fi 

        checkpid 
        if [ $pid -ne 0 ]; then 
            stop; 
        fi 
    else 
        echo "===========================================" 
        echo "===warn: rtt.jar is not running=====" 
        echo "===========================================" 
    fi 

} 

case $1 in 
start) 
echo "Starting Application Now......" 
start 
;;
stop) 
echo "Stopping Application Now......" 
stop 
;; 
*) 
esac 

exit 0
