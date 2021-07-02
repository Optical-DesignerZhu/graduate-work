clear
load initialW
W = initialW(1,:);
piexN =100;                                                            % 分割像素点
N =51;                                                                   %将原自由曲面分解成为小的子区域
% rangeX1 = [0.2 ,0];
% rangeY1 = [0.2 ,0];
% rangeX2 = [0 , -0.2];
% rangeY2 = [0.2 ,0];
% rangeX3 = [0 , -0.2];
% rangeY3 = [0 , -0.2];
% rangeX4 = [0.2 , 0];
% rangeY4 = [0 ,-0.2]; 
% preA1 = curvemergingRayTrace( W , rangeX1 , rangeY1,piexN);
% preA2 = curvemergingRayTrace( W , rangeX2 , rangeY2,piexN);
% preA3 = curvemergingRayTrace( W , rangeX3 , rangeY3,piexN);
% preA4 = curvemergingRayTrace( W , rangeX4 , rangeY4,piexN);
% preA1 = preA1(:)';
% preA2 = preA2(:)';
% preA3 = preA3(:)';
% preA4 = preA4(:)';
x = linspace(-0.1,0.1,N);
y = linspace(-0.1,0.1,N)';
X = meshgrid(x);
Y = rot90(meshgrid(y),1);
PreA = zeros((N -1)^2,10000);
Z = 0.255;
L = 0.01;
    for i = 1 : N-1 
        for j =1:N-1
            rangeX = [X(i ,j +1) , X(i +1,j)];
            rangeY = [Y(i ,j +1) , Y(i +1,j)];
            preA= curvemergingRayTrace( W , rangeX , rangeY,piexN,Z,L);
            PreA((i - 1) * (N - 1) + j,:) =preA(:)';
            k = ( i - 1) * (N - 1) + j
        end
    end
label = (1:2500)'; 
csvwrite('C:\Users\Administrator\tf1\label.csv',label);
%% 写入数据
csvwrite('C:\Users\Administrator\tf1\preA.csv',PreA);
%% 读取训练完成后预测的各项权重系数
load('C:\Users\Administrator\tf1\preW.mat');%加载预测得到的zernike各项的系数
preW = array;
load('C:\Users\Administrator\tf1\mergingpreW.mat');
mergingpreW= array;



for i = 1:50
    figure()
    showrebuild(preW(i,:));
end
