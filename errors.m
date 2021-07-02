clear
%% �ؽ�ǰ�����������������
% z��������
load('C:\Users\Administrator\tf1\preW.mat');%����Ԥ��õ���zernike�����ϵ��
pre_W = array;
load('C:\Users\Administrator\tf1\test_W.csv');%����ʵ�ʵ�zernike�����ϵ��
test_A = csvread('C:\Users\Administrator\tf1\test_A.csv');%��ȡ���Ե�ʵ�ʹ��ն�ͼ
num = size(pre_W,1);
maxerrorZ = zeros(num, 1);
RMS_errorZ = zeros(num, 1);
for i =1:num
%[~, ~,precom_Z] = zernike( pre_W(i, :) );
%[~, ~,testcom_Z] = zernike( test_W(i, :) );
errorZ = precom_Z - testcom_Z;
RMS_errorZ(i) = sqrt(sum(sum(errorZ .* errorZ)) / (size(errorZ,1))^2); % Z����������
maxerrorZ(i) = abs(max(errorZ(:)));                                                       %Z�����߶����
end

%% �ؽ���Ĺ��շֲ�������
N =100;                                                            % �ָ����ص�Ϊ100 *100
[num,m] = size(pre_W );
Pre_A = zeros(num, N^2);                           %��ʼ��Ԥ��Ĺ��ն�ͼ
for k =1: num
[rx, ry] = zernikecomb(pre_W(k,:));             %��ȡ�������Ƭ�����λ��
A = zeros(N,N);                                          
for i = 1:N
    for j =1:N
        A(i,j) = length(find(rx<=-2+(4*i)/N ...%ѡ��CCD�ķ�ΧΪ-2��2
            & rx> - 2+(4*i - 4)/N & ry<=-2+(4*j)/N & ry>-2+(4*j - 4)/N));
    end
end
Pre_A(k,:) = A(:)';
end
errorA =Pre_A - test_A;
RMS_errorA  = sqrt(sum(errorA .* errorA , 2) / ((size(errorA,2))^2));% ���նȵľ��������
