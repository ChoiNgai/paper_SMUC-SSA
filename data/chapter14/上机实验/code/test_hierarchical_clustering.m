%% hierarchical_clustering 测试代码
clear;
%% 初始化参数
type = 3; % 聚类的个数
filename='../data/standardized.xls'; % 标准化后的原始数据
picfilepre = '../tmp/商圈群组'; % 商圈群组保存图片名称前缀
hctree='../tmp/层次聚类树.png' ; % 层次聚类树保存路径
xlabels={'工作日人均停留时间','凌晨人均停留时间'...
    '周末人均停留时间','日均人流量'};           % x轴坐标

%% 调用层次聚类算法
typevec = hierachical_clustering(filename,type,picfilepre,hctree,xlabels);

disp('算法测试完成！');
