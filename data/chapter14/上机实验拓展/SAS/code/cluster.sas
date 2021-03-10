/*��ȡ�����ļ�business_circle.xls*/
%macro grabpath ; 
%qsubstr(%sysget(SAS_EXECFILEPATH),1, %length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILEname))-5
) 
%mend grabpath; 
%let path=%grabpath;
%let name=data\business_circle.xls; 
%let pathname=&path&name; 
%put &pathname;  /*pathnameΪbusiness_circle.xls��·��*/
%macro importdata ; 
PROC IMPORT OUT= WORK.business_circle 
            DATAFILE="&pathname" ;/*���ú����pathname*/
            sheet="��Ȧ��������";
			getnames=yes;
 RUN;
 %mend importdata;
 %importdata
/*�Ա������б�׼��*/
Proc standard  data=WORK.business_circle m = 0  s= 1 out= sta_data; 
var _COL1 _COL2 _COL3 _COL4;
run;
proc print data=sta_data;
run;
/*�Ա�׼�������ݽ��в�ξ���*/
proc cluster data=sta_data outtree=Tree method=ward  
                ccc pseudo print=15; /*�����붨��Ϊward��PSEUDOѡ��Ҫ�����αF��αt2ͳ������CCCѡ��Ҫ�����R2����ƫR2��CCCͳ������*/
      var _COL1 _COL2 _COL3 _COL4  ; 
      id _COL0; 
run;
/*������ϵ����ͼ*/
proc tree data=Tree n=3 horizontal out=cluster_result;/*������n=3*/
run;
proc print data=cluster_result;
run;

