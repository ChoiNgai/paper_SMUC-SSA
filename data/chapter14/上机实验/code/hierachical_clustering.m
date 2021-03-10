function typevec = hierachical_clustering(filename,type,picfilepre,hctree,xlabels)
%% ��ξ����㷨

% ���������
% filename�����������ļ���
% type��Ҫ�������������
% picfilepre��������ȦȺ������ͼ�ļ���ǰ׺��
% hctree�������ξ������ļ�����
% xlabels��Ⱥ������ͼ�����ꣻ

% ���������
% typevec���������ݵ����ţ�

%% ��ȡ����
num = xlsread(filename);

%% ��ξ���
Z = linkage(num,'ward','euclidean'); 
typevec = cluster(Z,'maxclust',type);

%% �������ͼ������

dendrogram(Z,0); 
set(gcf,'visible','off'); % ���ò�������
print(gcf,'-dpng',hctree);

 %% ���ÿ��Ⱥ�黭ͼ
for i=1:type
    data=num(typevec==i,:);
    plotrows(data,i,xlabels,picfilepre);
end

end