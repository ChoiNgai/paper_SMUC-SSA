/*读取数据文件business_circle.xls*/
%macro grabpath ; 
%qsubstr(%sysget(SAS_EXECFILEPATH),1, %length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILEname))-5
) 
%mend grabpath; 
%let path=%grabpath;
%let name=data\business_circle.xls; 
%let pathname=&path&name; 
%put &pathname;  /*pathname为business_circle.xls的路径*/
%macro importdata ; 
PROC IMPORT OUT= WORK.business_circle 
            DATAFILE="&pathname" ;/*引用宏变量pathname*/
            sheet="商圈分析数据";
			getnames=yes;
 RUN;
 %mend importdata;
 %importdata
/*对变量进行标准化*/
Proc standard  data=WORK.business_circle m = 0  s= 1 out= sta_data; 
var _COL1 _COL2 _COL3 _COL4;
run;
proc print data=sta_data;
run;
/*对标准化后数据进行层次聚类*/
proc cluster data=sta_data outtree=Tree method=ward  
                ccc pseudo print=15; /*类间距离定义为ward，PSEUDO选项要求计算伪F和伪t2统计量，CCC选项要求计算R2、半偏R2和CCC统计量。*/
      var _COL1 _COL2 _COL3 _COL4  ; 
      id _COL0; 
run;
/*画出谱系聚类图*/
proc tree data=Tree n=3 horizontal out=cluster_result;/*聚类数n=3*/
run;
proc print data=cluster_result;
run;

