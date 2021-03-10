function DB = obj_DBI(x)

% 数据及参数设置
load iris.csv
load irislabel.csv
data = iris;
label = irislabel;
cluster_n = max(label);
label_num = 10;
data_label = label(1:label_num);
lamda = 0.05;

% 根据标签信息生成先验隶属度矩阵
F=zeros(cluster_n,size(data, 1));
for k=1:cluster_n
 for i=1:size(data_label,1)%center第一行，第一类
   if data_label(i,1)==k
       F(k,i)=1;
   end
 end
end

% 向量拉伸成聚类中心
for i = 1:cluster_n
    for j = 1:size(data,2)
       center(i,j) = x(i+j); 
    end
end

% center = U*data./(sum(U,2)*ones(1,size(data,2)));

dist = pdist2(data,center, 'mahal')';             %    计算马氏距离

U_new=(ones(cluster_n, 1)*(1-sum(F))).*exp(-dist./lamda)./(ones(cluster_n, 1)*sum(exp(-dist./lamda)))+F;

cid = 1:cluster_n;
DB = DBI(data,cid);     %划分熵（越小越好）


end

function DB = DBI(x, cid)
    clusts = unique(cid);
    num = length(clusts);
    centroids = NaN(num,size(x,2));
    aveWithinD= zeros(num,1);
%算Wi
    for count =1:num
        members = (cid == clusts(count));
        if any(members)               %判断元素是否为非零元素any(v),如果v是非零元素返回true(即1)否则返回flase(即0)
            centroids(count,:) = mean(x(members,:),1);   %找到各类聚类中心
            %average Euclidean distance of each observation to the centroids
            aveWithinD(count)= mean(pdist2(x(members,:),centroids(count,:)));
        end
    end
    interD = pdist(centroids,'euclidean'); %Cij         
    R = zeros(num);
    for count = 1:num
        for j=count+1:num %j>i
            R(count,j)= (aveWithinD(count)+aveWithinD(j))/ interD((count-1)*(num-count/2)+j-count);%d((I-1)*(M-I/2)+J-I)
        end
    end
    R=R+R';


    RI = max(R,[],1);
    DB = mean(RI);
end
