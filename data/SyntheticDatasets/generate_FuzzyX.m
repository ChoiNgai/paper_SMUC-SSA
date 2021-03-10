function  [data,real_label]=generate_FuzzyX(X_Range, Y_Range, width, datanum_one_cluster)
%datanum_one_cluster：每类数据个数
% [data,real_label]=generate_FuzzyX([-3,3], [-2.5,2.5], 0.2, 500)
fid=fopen('FuzzyX.txt','w');
x_1=rand(1,datanum_one_cluster)*(X_Range(2)-X_Range(1))+X_Range(1);
x_2=rand(1,datanum_one_cluster)*(X_Range(2)-X_Range(1))+X_Range(1);
seita1=atan((Y_Range(2)-Y_Range(1))/(X_Range(2)-X_Range(1)));%角度
y_1=x_1*tan(seita1);
bias=randn(1,datanum_one_cluster)*width-width/2;
bias_x=bias*cos(pi/2-seita1);
bias_y=bias*sin(pi/2-seita1);
x_1=x_1-bias_x;
y_1=y_1+bias_y;
plot(x_1,y_1,'o');
hold on;
A=[x_1; y_1; ones(1,datanum_one_cluster)];
fprintf(fid,'%.2f %.2f %d\n',A); 
seita2=-seita1;%角度
y_2=x_2*tan(seita2);
bias=randn(1,datanum_one_cluster)*width-width/2;
bias_x=bias*cos(pi/2-seita2);
bias_y=bias*sin(pi/2-seita2);
x_2=x_2-bias_x;
y_2=y_2+bias_y;
plot(x_2,y_2,'o');
hold on;
xlabel('X');
ylabel('Y');
% title('FuzzyX');
B=[x_2; y_2; 2*ones(1,datanum_one_cluster)];
fprintf(fid,'%.2f %.2f %d\n',B); 
fclose(fid);
data_load=dlmread('FuzzyX.txt');
data=data_load(:,1:2);
real_label=data_load(:,3);