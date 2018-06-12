



    1.项目文件结构
    .
    ├── README.md
    ├── build.xml
    ├── data                                           //输入数据-每日文件格式2018-06-01；输入文件要包含当日和向前一周的文件
    │   ├── 2018-06-01
    │   ├── 2018-06-02
    │   ├── 2018-06-03
    │   ├── 2018-06-04
    │   ├── 2018-06-05
    │   ├── 2018-06-06
    │   ├── 2018-06-07
    │   ├── 20180529-2.txt
    │   ├── 20180529.txt
    │   ├── en.stop
    │   ├── telegram_crawler_message_dump_one_by_one.txt
    │   └── telegram_crawler_message_dump_one_by_one.zip
    ├── lib
    │   ├── stanford-corenlp-3.9.1-javadoc.jar
    │   ├── stanford-corenlp-3.9.1-models.jar
    │   ├── stanford-corenlp-3.9.1-sources.jar
    │   ├── stanford-corenlp-3.9.1.jar
    │   └── stanford-english-corenlp-2018-02-27-models.jar
    ├── result            //结果数据，每日产生一个文件夹2018-06-06，文件夹下有3个文件1 3 7，1代表当日最热话题，3代表3日最热话题，7代表7日内最热话题
    │   └── 2018-06-07
    │       ├── 1
    │       ├── 3
    │       └── 7
    └── src
    ├── com
    │   └── rtt
    │       ├── test
    │       │   └── TestServer.java
    │       └── util
    │           ├── FileNameDate.java
    │           ├── HashMapMerge.java
    │           ├── HashMapSort.java
    │           ├── StopWordFilter.java
    │           └── Writer.java
    └── startup.sh  //启动脚本
    
    
    2. 运行环境  
      java 1.8 以上版本
      
      
    3. 编译
       ant  
       编译生成  rrt.jar
        
    4. 运行  
       启动脚本  ./startup.sh start
 
