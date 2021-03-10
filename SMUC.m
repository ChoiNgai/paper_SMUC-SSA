function [U,center] = SMUC(data,cluster_n,data_label,center)
data_n = size(data, 1); % ���data�ĵ�һά(rows)��,����������
in_n = size(data, 2);   % ���data�ĵڶ�ά(columns)����������ֵ����
% Ĭ�ϲ�������
data = double(data);
data_label = double(data_label);
options = [2; % �����Ⱦ���U��ָ��
   1000;                % ����������
   1e-5;               % ��������С�仯��,������ֹ����
   1];                 % ÿ�ε����Ƿ������Ϣ��־

%��options �еķ����ֱ�ֵ���ĸ�����;
expo = options(1);          % �����Ⱦ���U��ָ��
max_iter = options(2);  % ����������
min_impro = options(3);  % ��������С�仯��,������ֹ����
display = options(4);  % ÿ�ε����Ƿ������Ϣ��־
lamda = 0.02;
center_count = zeros(max_iter, 1); % ��ʼ���������obj_fcn
%��ʼ��center,F
[~,F] = initcenter(data_label,data,cluster_n);


% ��ʼ�����Ⱦ���
dist = pdist2(data,center, 'mahal')';             %    �������Ͼ���
U = (ones(cluster_n, 1)*(1-sum(F))).*exp(-dist./lamda)./(ones(cluster_n, 1)*sum(exp(-dist./lamda)))+F;


% Main loop  ��Ҫѭ��
for i = 1:max_iter
       [U, center] = stepfcm(data,U,cluster_n,F,lamda);
       center_count(i)=norm(center);%��ģnorm
   if display
      fprintf('SMUC:Iteration count = %d\n', i);
   end
% ��ֹ�����б�
   if i>1
     if abs(center_count(i) - center_count(i-1)) < min_impro
           break;
     end
   end
end


end


function [center,F] = initcenter(data_label,data,cluster_n)%Ĭ��Ϊ��3��
center=zeros(cluster_n,size(data, 2));%����Ҫ��
F=zeros(cluster_n,size(data, 1));%����Ҫ��
for k=1:cluster_n
 for i=1:size(data_label,1)%center��һ�У���һ��
   if data_label(i,1)==k
       F(k,i)=1;
       for j=2:size(data_label,2)-1
          center(k,j)=(data_label(i,j)+center(k,j))/i;
       end
   end
 end
end
  
end



% �Ӻ���
function [U_new, center] = stepfcm(data,U,cluster_n,F,lamda)
% ģ��C��ֵ����ʱ������һ��
% ���룺
%   data        ---- nxm����,��ʾn������,ÿ����������m��ά����ֵ
%   U           ---- �����Ⱦ���
%   cluster_n   ---- ����,��ʾ�ۺ�������Ŀ,�������
%   expo        ---- �����Ⱦ���U��ָ��                     
% �����
%   U_new       ---- ������������µ������Ⱦ���
%   center      ---- ������������µľ�������
%   obj_fcn     ---- Ŀ�꺯��ֵ


center = U*data./(sum(U,2)*ones(1,size(data,2)));                %    �������
dist = pdist2(data,center, 'mahal')';             %    �������Ͼ���

U_new=(ones(cluster_n, 1)*(1-sum(F))).*exp(-dist./lamda)./(ones(cluster_n, 1)*sum(exp(-dist./lamda)))+F;

end


% �Ӻ���
function out = distfcm(center, data)
% �������������������ĵľ���
% ���룺
%   center     ---- ��������
%   data       ---- ������
% �����
%   out        ---- ����
out = zeros(size(center, 1), size(data, 1));
 for k = 1:size(center, 1) % ��ÿһ����������
   % ÿһ��ѭ��������������㵽һ���������ĵľ���
   out(k, :) = sqrt(sum(((data-ones(size(data,1),1)*center(k,:)).^2)',1));
 end
end


