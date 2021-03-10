function plotrows( data,i ,xlabels,picfilepre)
%% ��ͼ ������

% ���������
% data�� ԭʼ���ݣ����зֲ���
% i���������������Ⱥ�飻
% xlabels�� �������ַ�����
% picfilepre�� Ⱥ������ͼ�����ļ���ǰ׺��

%% ��ȡ�������У����л�ͼ
[rows,cols] = size(data);

%% ��ͼ
figure(100+i);
set(gcf,'visible','off'); % ���ò�������
hold on;
for k=1:rows
   plot(1:cols,data(k,:),'-ok');
end

hold off;

%  ����ͼƬ����
title(['��Ȧ���' num2str(i)]);
set(gca,'xtick',1:cols);
set(gca,'xticklabel',xlabels);

%% ����ͼƬ
print(gcf,'-dpng',[picfilepre num2str(i) '.png']);

end

