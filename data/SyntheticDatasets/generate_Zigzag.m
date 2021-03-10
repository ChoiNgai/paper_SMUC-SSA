function [data,real_label]=generate_Zigzag(width, datanum_one_cluster)
%datanum_one_cluster：每类数据个数
% [data,real_label]=generate_Zigzag(0.1, 501)
fid=fopen('Zigzag.txt','w');
seita1=atan(2/1.5);
seita2=atan(-2/1.5);
seita3=seita1;
x_1=rand(1,datanum_one_cluster/3)*1.5-2;
x_2=rand(1,datanum_one_cluster/3)*1.5-0.5;
x_3=rand(1,datanum_one_cluster/3)*1.5+1;
y_1=x_1*tan(seita1)+1.7;
y_2=x_2*tan(seita2)+0.4;
y_3=x_3*tan(seita3)-2.3;
 
bias=randn(1,datanum_one_cluster)*width-width/2;
bias_x_1=bias(1:datanum_one_cluster/3)*cos(pi/2-seita1);
bias_y_1=bias(1:datanum_one_cluster/3)*sin(pi/2-seita1);
bias_x_2=bias(datanum_one_cluster/3+1:2*datanum_one_cluster/3)*cos(pi/2-seita2);
bias_y_2=bias(datanum_one_cluster/3+1:2*datanum_one_cluster/3)*sin(pi/2-seita2);
bias_x_3=bias(2*datanum_one_cluster/3+1:3*datanum_one_cluster/3)*cos(pi/2-seita3);
bias_y_3=bias(2*datanum_one_cluster/3+1:3*datanum_one_cluster/3)*sin(pi/2-seita3);
 
x_1=x_1-bias_x_1;
y_1=y_1+bias_y_1;
x_2=x_2-bias_x_2;
y_2=y_2+bias_y_2;
x_3=x_3-bias_x_3;
y_3=y_3+bias_y_3;
x=[x_1';x_2';x_3'];
y=[y_1';y_2';y_3'];
plot(x,y,'o');
hold on;
A=[x'; y'; ones(1,datanum_one_cluster)];
fprintf(fid,'%.2f %.2f %d\n',A); 
mu1=[-0.5,-0.75];
sigma1=[0.01 0; 0 0.01];
z1=mvnrnd(mu1,sigma1,ceil(datanum_one_cluster/2));
mu2=[1,0.75];
sigma2=[0.01 0; 0 0.01];
z2=mvnrnd(mu2,sigma2,datanum_one_cluster-ceil(datanum_one_cluster/2));
z=[z1;z2];
plot(z(:,1),z(:,2),'o');
hold on;
xlabel('X');
ylabel('Y');
% title('Zigzag');
B=[(z(:,1))'; (z(:,2))'; 2*ones(1,datanum_one_cluster)];
fprintf(fid,'%.2f %.2f %d\n',B); 
fclose(fid);
data_load=dlmread('Zigzag.txt');
data=data_load(:,1:2);
real_label=data_load(:,3);