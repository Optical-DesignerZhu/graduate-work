clear
tic
N =100;                                                            % �ָ����ص�Ϊ100 * 100
num =20000;                                                  %���ɵ��������ĸ���
Tra_A = zeros(num, N^2);                           %��ʼ���նȾ���
Tra_W = zeros(num, 15);                               %��ʼZernike����ϵ��Ȩ��
for k =1: num
W =1 - 2 * rand(1,15);                                               %�������Ȩ��ȡֵ
W =  W / norm(W);                                        %��һ��Ȩ��ָ��
Tra_W(k, :) = W;
[rx, ry] = zernikecomb( Tra_W(k,:));                          %��ȡ�������Ƭ�����λ��
A = zeros(N,N);         
for i = 1:N
    for j =1:N
        A(i,j) = length(find(rx<=-2+(4*i)/N ...%ѡ��CCD�ķ�ΧΪ-2��2
            & rx> - 2+(4*i - 4)/N & ry<=-2+(4*j)/N & ry>-2+(4*j - 4)/N));
    end
end
Tra_A(k,:) = A(:)';
k
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
%  csvwrite('C:\Users\Administrator\tf1\curvemergingTra_W.csv',Tra_W);
%  csvwrite('C:\Users\Administrator\tf1\curvemergingTra_A.csv',Tra_A);
