function typevec = hierachical_clustering(filename,type,picfilepre,hctree,xlabels)
%% 层次聚类算法

% 输入参数：
% filename：数据所在文件；
% type：要聚类的类别个数；
% picfilepre：保存商圈群组趋势图文件名前缀；
% hctree：保存层次聚类树文件名；
% xlabels：群组趋势图横坐标；

% 输出参数：
% typevec：输入数据的类别号；

%% 读取数据
num = xlsread(filename);

%% 层次聚类
Z = linkage(num,'ward','euclidean'); 
typevec = cluster(Z,'maxclust',type);

%% 画层次树图并保存

dendrogram(Z,0); 
set(gcf,'visible','off'); % 设置不弹出框
print(gcf,'-dpng',hctree);

 %% 针对每个群组画图
for i=1:type
    data=num(typevec==i,:);
    plotrows(data,i,xlabels,picfilepre);
end

end