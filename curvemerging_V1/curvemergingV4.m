clear
load initialW
W = initialW(1,:);
piexN =100;                                                            % 分割像素点
N =2;                                                                        %子区域被划分的网格数
Z = 0.6;                                                                    %光源的高度
L = 2;                                                                        %接受面的大小 

x = linspace(-0.2,0.2,2*N+1);
y = linspace(-0.2,0.2,2*N+1)';
X = meshgrid(x);
Y = rot90(meshgrid(y),1);
PreA = zeros(N^2,10000);
rangeX = zeros(N^2,2);
rangeY  = zeros(N^2,2);
    for i = 1:N
        for j =1:N
            temp_rangeX = [X(i  ,j + N + 1) , X(i + N +1,j )];
            temp_rangeY = [Y(i ,j + N + 1) , Y(i + N + 1,j )];
            preA= curvemergingRayTrace( W , rangeX , rangeY,piexN,Z,L);
            PreA((i - 1) * N + j,:) =preA(:)';
            rangeX((i - 1) * N + j,:) =  temp_rangeX;
            rangeY((i - 1) * N + j,:) =  temp_rangeY;
            k = ( i - 1) * N + j
        end
    end

%% 写入数据
%csvwrite('C:\Users\Administrator\tf1\preA.csv',PreA);
%% 读取训练完成后预测的各项权重系数
load('C:\Users\Administrator\tf1\preW.mat');%加载预测得到的zernike各项的系数
preW = array;
%  for i =1:4
% figure();
% [~,~,com_Z] = showrebuild(preW(i,:),rangeX(i,:),rangeY(i,:));
%  end

%% 得到拼接后的原始图片
npiex = 20;
Z = [];
for j = 1:2
    Zx =[];
    for i =1:2
    [~,~,com_Z] = showrebuild(preW((j -1)*2+ i,:) ,rangeX((j -1)*2+ i,:) , rangeY((j -1)*2+ i,:) );
    Zx = [Zx com_Z];
    end
    Z = [Zx;Z];
end

%% 将列向量移到同一个高度上
for j = 1:2
    for i =1:1
        Z((npiex*i+1:npiex*(i+1)) , ((j -1)*npiex +1:npiex*j))=Z((npiex*i+1:npiex*(i+1)) , ((j -1)*npiex +1:npiex*j)) + sum(Z(npiex *i ,(j-1)*npiex + 1 : j * npiex) -Z(npiex*i + 1 ,(j-1)*npiex + 1 : j * npiex)) / npiex;
    end
end
 %% 将行向量移到同一个高度上
 for k =1
     Z(: , npiex * k +1 : npiex * ( k +1 )) =  Z(: , npiex * k +1 : npiex * ( k +1 )) + sum(Z(: , npiex * k) - Z(: , npiex * k + 1)) / size(Z , 1);
 end
%% 得到修正后拼接的图片
[X, Y]= meshgrid(linspace(-0.1,0.1,2*npiex) , linspace(-0.1,0.1,2*npiex));
figure()
surf(X,Y,Z,'FaceAlpha',0.5);
