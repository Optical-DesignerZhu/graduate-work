clear
tic
N =100;                                                            % 分割像素点为100 * 100
num =10000;                                                  %生成的样本集的个数
Tra_A = zeros(num, N^2);                           %初始化照度矩阵
Tra_W = zeros(num, 15);                               %初始Zernike各项系数权重
for k =1: num
W = rand(1,15);                                               %随机生成权重取值
W =  W / norm(W);                                        %归一化权重指标
Tra_W(k, :) = W;
[rx, ry] = zernikecomb( W);                          %读取所需的照片坐标点位置
A = zeros(N,N);         
for i = 1:N
    for j =1:N
        A(i,j) = length(find(rx<=-2+(4*i)/N ...%选择CCD的范围为-2到2
            & rx> - 2+(4*i - 4)/N & ry<=-2+(4*j)/N & ry>-2+(4*j - 4)/N));
    end
end
Tra_A(k,:) = A(:)';
end
toc
                                                                           
tic                                                                       %剔除无效数据
ind = sum(Tra_A,2);
k = find(ind ~=size(rx,2));
Tra_A(k,:) = [];
Tra_W(k,:) = [];
 displayData(Tra_A);
toc
%%写入数据
% csvwrite('C:\Users\Administrator\tf1\Tra_W.csv',Tra_W);
% csvwrite('C:\Users\Administrator\tf1\Tra_A.csv',Tra_A);
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
[rx, ry] = zernikecomb( W);                           %读取所需的照片坐标点位置
A = zeros(N,N);
for i = 1:N
    for j =1:N
        A(i,j) = length(find(rx<=-2+(4*i)/N ...%选择CCD的范围为-2到2
            & rx> - 2+(4*i - 4)/N & ry<=-2+(4*j)/N & ry>-2+(4*j - 4)/N));
    end
end
test_A(k,:) = A(:)';
end

ind = sum(test_A,2);                                       %剔除无效数据
k = find(ind ~=size(rx,2));
test_A(k,:) = [];
test_W(k,:) = [];
%%写入数据
% csvwrite('C:\Users\Administrator\tf1\test_W.csv',test_W);
% csvwrite('C:\Users\Administrator\tf1\test_A.csv',test_A);