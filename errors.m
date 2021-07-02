clear
%% 重建前后的自由曲面误差分析
% z轴最大误差
load('C:\Users\Administrator\tf1\preW.mat');%加载预测得到的zernike各项的系数
pre_W = array;
load('C:\Users\Administrator\tf1\test_W.csv');%加载实际的zernike各项的系数
test_A = csvread('C:\Users\Administrator\tf1\test_A.csv');%读取测试的实际光照度图
num = size(pre_W,1);
maxerrorZ = zeros(num, 1);
RMS_errorZ = zeros(num, 1);
for i =1:num
%[~, ~,precom_Z] = zernike( pre_W(i, :) );
%[~, ~,testcom_Z] = zernike( test_W(i, :) );
errorZ = precom_Z - testcom_Z;
RMS_errorZ(i) = sqrt(sum(sum(errorZ .* errorZ)) / (size(errorZ,1))^2); % Z轴均方根误差
maxerrorZ(i) = abs(max(errorZ(:)));                                                       %Z轴最大高度误差
end

%% 重建后的光照分布误差分析
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
errorA =Pre_A - test_A;
RMS_errorA  = sqrt(sum(errorA .* errorA , 2) / ((size(errorA,2))^2));% 光照度的均方根误差
