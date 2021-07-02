% for i =1:15
%      W = zeros(1,15);
%      W(i) =1;
%      figure()
%      showrebulid( W );
%  end
%% 测试集数据导入
                                                                          %生成测试集
N =100;                                                            % 分割像素点
num =10;                                                         %生成的测试集的个数
test_A = zeros(num, N^2);                          %初始化照度矩阵
test_W = zeros(num, 15);                              %初始Zernike各项系数权重
for k =1: num
W = rand(1,15);
W =  W / norm(W);
test_W(k, :) = W;
A = curvemergingRayTrace( W , [0.1 , - 0.1] , [0.1 , - 0.1] ,100);
test_A(k,:) = A(:)';
end

%%写入数据
csvwrite('C:\Users\Administrator\tf1\test_W1.csv',test_W);
csvwrite('C:\Users\Administrator\tf1\test_A1.csv',test_A);

