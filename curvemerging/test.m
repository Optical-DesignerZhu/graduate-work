% for i =1:15
%      W = zeros(1,15);
%      W(i) =1;
%      figure()
%      showrebulid( W );
%  end
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
A = curvemergingRayTrace( W , [0.1 , - 0.1] , [0.1 , - 0.1] ,100);
test_A(k,:) = A(:)';
end

%%д������
csvwrite('C:\Users\Administrator\tf1\test_W1.csv',test_W);
csvwrite('C:\Users\Administrator\tf1\test_A1.csv',test_A);

