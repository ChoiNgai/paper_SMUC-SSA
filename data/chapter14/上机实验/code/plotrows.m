function plotrows( data,i ,xlabels,picfilepre)
%% 画图 并保存

% 输入参数：
% data： 原始数据，按行分布；
% i：数据类别，所属的群组；
% xlabels： 横坐标字符串；
% picfilepre： 群组趋势图保存文件名前缀；

%% 获取数据行列，按行画图
[rows,cols] = size(data);

%% 画图
figure(100+i);
set(gcf,'visible','off'); % 设置不弹出框
hold on;
for k=1:rows
   plot(1:cols,data(k,:),'-ok');
end

hold off;

%  设置图片属性
title(['商圈类别' num2str(i)]);
set(gca,'xtick',1:cols);
set(gca,'xticklabel',xlabels);

%% 保存图片
print(gcf,'-dpng',[picfilepre num2str(i) '.png']);

end

