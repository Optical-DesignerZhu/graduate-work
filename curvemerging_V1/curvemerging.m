clear
%% 完整自由曲面数据导入
W = initialW(1,:);
piexN =100;                                                            % 分割像素点
rangeX1 = [0.2 ,0];
rangeY1 = [0.2 ,0];
rangeX2 = [0 , -0.2];
rangeY2 = [0.2 ,0];
rangeX3 = [0 , -0.2];
rangeY3 = [0 , -0.2];
rangeX4 = [0.2 , 0];
rangeY4 = [0 ,-0.2]; 
preA1 = curvemergingRayTrace( W , rangeX1 , rangeY1,piexN);
preA2 = curvemergingRayTrace( W , rangeX2 , rangeY2,piexN);
preA3 = curvemergingRayTrace( W , rangeX3 , rangeY3,piexN);
preA4 = curvemergingRayTrace( W , rangeX4 , rangeY4,piexN);
preA1 = preA1(:)';
preA2 = preA2(:)';
preA3 = preA3(:)';
preA4 = preA4(:)';
%% 写入数据
csvwrite('C:\Users\Administrator\tf1\preA1.csv',preA1);
csvwrite('C:\Users\Administrator\tf1\preA2.csv',preA2);
csvwrite('C:\Users\Administrator\tf1\preA3.csv',preA3);
csvwrite('C:\Users\Administrator\tf1\preA4.csv',preA4);

%% 读取训练完成后预测的各项权重系数
load('C:\Users\Administrator\tf1\preW1.mat');%加载预测得到的zernike各项的系数
pre_W1 = array;
load('C:\Users\Administrator\tf1\preW2.mat');
pre_W2 = array;
load('C:\Users\Administrator\tf1\preW3.mat');
pre_W3 = array;
load('C:\Users\Administrator\tf1\preW4.mat');
pre_W4 = array;
load('C:\Users\Administrator\tf1\mergingpreW.mat');
mergingpreW= array;

figure()
subplot(2,2,2)
showrebuild(pre_W1);
subplot(2,2,1)
showrebuild(pre_W2);
subplot(2,2,3)
showrebuild(pre_W3);
subplot(2,2,4)
showrebuild(pre_W4);


for i = 1:10
    figure()
%     subplot(1,2,1)
    showrebuild(test_W(i,:));
%     subplot(1,2,2)
%     showrebuild(mergingpreW(i,:));
end
