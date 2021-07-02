clear
%% 显示实际的光照分布图以及重建后的光照分布图
load('C:\Users\Administrator\tf1\preW.mat');%加载预测得到的zernike各项的系数
pre_W = array;
load('C:\Users\Administrator\tf1\test_W.csv');%加载实际的zernike各项的系数
test_A = csvread('C:\Users\Administrator\tf1\test_A.csv');%读取测试的实际光照度图
N =100;                                                            % 分割像素点为100 *100
[num,m] = size(pre_W );
Pre_A = zeros(num, N^2);                           %初始化预测的光照度图
for k =1: num
[rx, ry] = zernikecomb(pre_W(k,:));             %读取所需的照片坐标点位置
A = zeros(N,N);                                          
for i = 1:N
    for j =1:N
        A(i,j) = length(find(rx<=-2+(4*i)/N ...%选择CCD的范围为-2到2
            & rx> - 2+(4*i - 4)/N & ry<=-2+(4*j)/N & ry>-2+(4*j - 4)/N));
    end
end
Pre_A(k,:) = A(:)';
end
displayData(Pre_A);                                        %展示预测得到的光照度图
figure()
displayData(test_A);                                        %展示实际的光照度图
%% 显示重建后的自由曲面和原来的自由曲面的对比
for i = 1:num
    figure()
    subplot(1,2,1)
    W = pre_W(i,:);                                          %展示重建后的自由曲面
    showrebuild(W)
    W = test_W(i,:);                                          %展示原来的自由曲面
    subplot(1,2,2)
    showrebuild(W)
end
