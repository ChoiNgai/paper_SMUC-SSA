function [data,real_label]=generate_ring(large_R,small_R,width,datanum_one_cluster)
%[data,real_label]=generate_ring(0.85,0.15,0.15,500)
%前两列是数据，最后一列是标签（1，2）
%datanum_one_cluster: 每一类点的个数
format long
seita_1=rand(1,datanum_one_cluster)*2*pi;%角度
r_1=rand(1,datanum_one_cluster)*width+large_R;%半径
x_1=r_1.*cos(seita_1);
y_1=r_1.*sin(seita_1);
A=[x_1; y_1; ones(1,datanum_one_cluster)];
plot(x_1,y_1,'o');
hold on;
fid=fopen('ring.txt','w');
fprintf(fid,'%.2f %.2f %d\n',A); 
seita_2=rand(1,datanum_one_cluster)*2*pi;%角度
r_2=rand(1,datanum_one_cluster)*width+small_R;%半径
x_2=r_2.*cos(seita_2);
y_2=r_2.*sin(seita_2);
B=[x_2; y_2; 2*ones(1,datanum_one_cluster)];
plot(x_2,y_2,'o');
xlabel('X');
ylabel('Y');
% title('ring');
fprintf(fid,'%.2f %.2f %d\n',B); 
fclose(fid);
data_load=dlmread('ring.txt');
data=data_load(:,1:2);
real_label=data_load(:,3);