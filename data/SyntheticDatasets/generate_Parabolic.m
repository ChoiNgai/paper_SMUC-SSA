function [data,real_label]=generate_Parabolic(X1_Range, X2_Range, width, datanum_one_cluster)
%datanum_one_cluster：每类数据个数
% [data,real_label]=generate_Parabolic([-2,1], [-1,2], 0.15, 500)
x_1=rand(1,datanum_one_cluster)*(X1_Range(2)-X1_Range(1))+X1_Range(1);
x_2=rand(1,datanum_one_cluster)*(X2_Range(2)-X2_Range(1))+X2_Range(1);
fid=fopen('Parabolic.txt','w');
y_1=(x_1+0.55).^2-1.5;
bias_x=randn(1,datanum_one_cluster)*width-width/2;
bias_y=randn(1,datanum_one_cluster)*width-width/2;
x_1=x_1+bias_x;
y_1=y_1+bias_y;
plot(x_1,y_1,'o');
hold on;
A=[x_1; y_1; ones(1,datanum_one_cluster)];
fprintf(fid,'%.2f %.2f %d\n',A); 
y_2=-(x_2-0.55).^2+1.5;
bias_x=randn(1,datanum_one_cluster)*width-width/2;
bias_y=randn(1,datanum_one_cluster)*width-width/2;
x_2=x_2-bias_x;
y_2=y_2+bias_y;
plot(x_2,y_2,'o');
hold on;
xlabel('X');
ylabel('Y');
% title('Parabolic');
B=[x_2; y_2; 2*ones(1,datanum_one_cluster)];
fprintf(fid,'%.2f %.2f %d\n',B); 
fclose(fid);
data_load=dlmread('Parabolic.txt');
data=data_load(:,1:2);
real_label=data_load(:,3);