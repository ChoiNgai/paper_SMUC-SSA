addpath ClustFunction
addpath data
addpath index

clear all 
close all
load wine.csv
load winelabel.csv
load iris.csv
load irislabel.csv
dataset = "iris";
data = iris;
label = irislabel;
cluster_n = max(label);
data = ( data - min(data) ) ./( max(data) - min(data) );    %归一化
label_num = 10;

SearchAgents_no=30; % Number of search agents

Function_name='F10'; % Name of the test function that can be from F1 to F23

Max_iteration=100; % Maximum numbef of iterations

lb = 0;
ub = 1;
dim = size(data,2)*cluster_n;
fobj = @obj_DBI;

[Best_score,Best_pos,SSA_cg_curve]=SSA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
best_center = reshape(Best_pos,cluster_n,size(data,2)); 
[U,center] = SMUC(data,cluster_n,label(1:label_num),best_center);

