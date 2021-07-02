clear
%% ��ʾʵ�ʵĹ��շֲ�ͼ�Լ��ؽ���Ĺ��շֲ�ͼ
load('C:\Users\Administrator\tf1\preW.mat');%����Ԥ��õ���zernike�����ϵ��
pre_W = array;
load('C:\Users\Administrator\tf1\test_W.csv');%����ʵ�ʵ�zernike�����ϵ��
test_A = csvread('C:\Users\Administrator\tf1\test_A.csv');%��ȡ���Ե�ʵ�ʹ��ն�ͼ
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
displayData(Pre_A);                                        %չʾԤ��õ��Ĺ��ն�ͼ
figure()
displayData(test_A);                                        %չʾʵ�ʵĹ��ն�ͼ
%% ��ʾ�ؽ�������������ԭ������������ĶԱ�
for i = 1:num
    figure()
    subplot(1,2,1)
    W = pre_W(i,:);                                          %չʾ�ؽ������������
    showrebuild(W)
    W = test_W(i,:);                                          %չʾԭ������������
    subplot(1,2,2)
    showrebuild(W)
end
