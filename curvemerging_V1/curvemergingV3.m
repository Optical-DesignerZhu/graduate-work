clear
load initialW
W = initialW(1,:);
piexN =100;                                                            % 分割像素点
N =2;  
Z = 0.6;
L = 2;
%将原自由曲面分解成为小的子区域
rangeX1 = [0.2 ,0];
rangeY1 = [0.2 ,0];
rangeX2 = [0 , -0.2];
rangeY2 = [0.2 ,0];
rangeX3 = [0 , -0.2];
rangeY3 = [0 , -0.2];
rangeX4 = [0.2 , 0];
rangeY4 = [0 ,-0.2]; 
preA1 = curvemergingRayTrace( W , rangeX1 , rangeY1,piexN,Z,L);
preA2 = curvemergingRayTrace( W , rangeX2 , rangeY2,piexN,Z,L);
preA3 = curvemergingRayTrace( W , rangeX3 , rangeY3,piexN,Z,L);
preA4 = curvemergingRayTrace( W , rangeX4 , rangeY4,piexN,Z,L);
preA1 = preA1(:)';
preA2 = preA2(:)';
preA3 = preA3(:)';
preA4 = preA4(:)';
PreA = [preA1;preA2;preA3;preA4];


x = linspace(-0.2,0.2,2*N+1);
y = linspace(-0.2,0.2,2*N+1)';
X = meshgrid(x);
Y = rot90(meshgrid(y),1);
PreA = zeros(N^2,10000);

    for i = 1:N
        for j =1:N
            rangeX = [X(i  ,j + N + 1) , X(i + N +1,j )];
            rangeY = [Y(i ,j + N + 1) , Y(i + N + 1,j )];
            preA= curvemergingRayTrace( W , rangeX , rangeY,piexN,Z,L);
            PreA((i - 1) * N + j,:) =preA(:)';
            k = ( i - 1) * N + j
        end
    end

%% 写入数据
csvwrite('C:\Users\Administrator\tf1\preA.csv',PreA);
%% 读取训练完成后预测的各项权重系数
load('C:\Users\Administrator\tf1\preW.mat');%加载预测得到的zernike各项的系数
npiex = 20;
preW = array;
Z = [];
for j = 1:2
    Zx =[];
    for i =1:2
    [~,~,com_Z] = showrebuild(preW((j -1)*2+ i,:));
    Zx = [Zx com_Z];
    end
    Z = [Z;Zx];
end

for j = 1:2
    for i =1:1
        Z(((j -1)*npiex +1):npiex*j,npiex*i+1:npiex*(i+1)) = Z(((j -1)*npiex +1):npiex*j,npiex*i+1:npiex*(i+1)) + Z((j-1)*npiex + 1,npiex *i) -Z((j-1)*npiex + 1,npiex*i + 1);
    end
end

% for j = 1:50
%     for i =1:49
%         Z((npiex*i+1:npiex*(i+1)) , ((j -1)*npiex +1:npiex*j))=Z((npiex*i+1:npiex*(i+1)) , ((j -1)*npiex +1:npiex*j)) + Z(npiex *i ,(j-1)*npiex + 1) -Z(npiex*i + 1 ,(j-1)*npiex + 1);
%     end
% end
 
for i =1:1
    Z(npiex * i + 1:npiex* (i + 1), :) = Z(npiex * i + 1:npiex* (i + 1),:) +  Z(npiex * i,1) - Z(npiex * i + 1,1);
end

for i = 1:2
    Z(npiex * i + 1:npiex* (i + 1), :) =  Z(npiex * i + 1:npiex* (i + 1),:) - sum((Z(npiex * i +1 , :) - Z(npiex * i , :))) / (50 * npiex);
end
[X, Y]= meshgrid(linspace(-0.1,0.1,2*npiex) , linspace(-0.1,0.1,2*npiex));
figure()
surf(X,Y,Z,'FaceAlpha',0.5);
