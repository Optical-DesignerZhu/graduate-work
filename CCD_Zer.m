clear
tic
N =100;                                                            % �ָ����ص�Ϊ100 * 100
num =10000;                                                  %���ɵ��������ĸ���
Tra_A = zeros(num, N^2);                           %��ʼ���նȾ���
Tra_W = zeros(num, 15);                               %��ʼZernike����ϵ��Ȩ��
for k =1: num
W = rand(1,15);                                               %�������Ȩ��ȡֵ
W =  W / norm(W);                                        %��һ��Ȩ��ָ��
Tra_W(k, :) = W;
[rx, ry] = zernikecomb( W);                          %��ȡ�������Ƭ�����λ��
A = zeros(N,N);         
for i = 1:N
    for j =1:N
        A(i,j) = length(find(rx<=-2+(4*i)/N ...%ѡ��CCD�ķ�ΧΪ-2��2
            & rx> - 2+(4*i - 4)/N & ry<=-2+(4*j)/N & ry>-2+(4*j - 4)/N));
    end
end
Tra_A(k,:) = A(:)';
end
toc
                                                                           
tic                                                                       %�޳���Ч����
ind = sum(Tra_A,2);
k = find(ind ~=size(rx,2));
Tra_A(k,:) = [];
Tra_W(k,:) = [];
 displayData(Tra_A);
toc
%%д������
% csvwrite('C:\Users\Administrator\tf1\Tra_W.csv',Tra_W);
% csvwrite('C:\Users\Administrator\tf1\Tra_A.csv',Tra_A);
%% ���Լ����ݵ���
                                                                           %���ɲ��Լ�
N =100;                                                            % �ָ����ص�
num =10;                                                         %���ɵĲ��Լ��ĸ���
test_A = zeros(num, N^2);                          %��ʼ���նȾ���
test_W = zeros(num, 15);                              %��ʼZernike����ϵ��Ȩ��
for k =1: num
W = rand(1,15);
W =  W / norm(W);
test_W(k, :) = W;
[rx, ry] = zernikecomb( W);                           %��ȡ�������Ƭ�����λ��
A = zeros(N,N);
for i = 1:N
    for j =1:N
        A(i,j) = length(find(rx<=-2+(4*i)/N ...%ѡ��CCD�ķ�ΧΪ-2��2
            & rx> - 2+(4*i - 4)/N & ry<=-2+(4*j)/N & ry>-2+(4*j - 4)/N));
    end
end
test_A(k,:) = A(:)';
end

ind = sum(test_A,2);                                       %�޳���Ч����
k = find(ind ~=size(rx,2));
test_A(k,:) = [];
test_W(k,:) = [];
%%д������
% csvwrite('C:\Users\Administrator\tf1\test_W.csv',test_W);
% csvwrite('C:\Users\Administrator\tf1\test_A.csv',test_A);