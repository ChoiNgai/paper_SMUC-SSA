%% hierarchical_clustering ���Դ���
clear;
%% ��ʼ������
type = 3; % ����ĸ���
filename='../data/standardized.xls'; % ��׼�����ԭʼ����
picfilepre = '../tmp/��ȦȺ��'; % ��ȦȺ�鱣��ͼƬ����ǰ׺
hctree='../tmp/��ξ�����.png' ; % ��ξ���������·��
xlabels={'�������˾�ͣ��ʱ��','�賿�˾�ͣ��ʱ��'...
    '��ĩ�˾�ͣ��ʱ��','�վ�������'};           % x������

%% ���ò�ξ����㷨
typevec = hierachical_clustering(filename,type,picfilepre,hctree,xlabels);

disp('�㷨������ɣ�');
