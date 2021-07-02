clear
load initialW
W = initialW(1,:);
piexN =100;                                                            % 分割像素点
N =10;                                                                        %子区域被划分的网格数
h = 0.6;                                                                    %光源的高度
L = 2;                                                                        %接受面的大小 

x = linspace(-(2 * N - 1) / (10 * N),(2 * N - 1) /  (10 * N),2 * N);
y = linspace(-(2 * N - 1) / (10 * N ),(2 * N - 1) / (10 * N),2 * N);
X = meshgrid(x);
Y = rot90(meshgrid(y),1);
PreA = zeros(N^2,10000);
rangeX = zeros(N^2,2);
rangeY  = zeros(N^2,2);
initialh = 0.28;
    for i = 1:N
        for j =1:N
            temp_rangeX = [X(i  ,j + N) , X(i + N ,j )];
            temp_rangeY = [Y(i ,j + N) , Y(i + N ,j )];
            rangeX((i - 1) * N + j,:) =  temp_rangeX;
            rangeY((i - 1) * N + j,:) =  temp_rangeY;
            com_Z = showh(W ,temp_rangeX ,temp_rangeY);
            com_Z= com_Z(:);
            H = com_Z(61);
            delta = initialh - H;
            preA= curvemergingRayTrace( W , rangeX((i - 1) * N + j,:) , rangeY((i - 1) * N + j,:),piexN,h - delta,L);
            PreA((i - 1) * N + j,:) =preA(:)';
            k = ( i - 1) * N + j
        end
    end
%% 写入数据
csvwrite('C:\Users\Administrator\tf1\preA.csv',PreA);
%% 读取训练完成后预测的各项权重系数
load('C:\Users\Administrator\tf1\preW.mat');%加载预测得到的zernike各项的系数
preW = array;
%% 得到拼接后的原始图片
npiex =50;
Z = [];
for j = 1:N
    Zx =[];
    for i =1:N
    [~,~,com_Z] = showrebuild(preW((j -1)*N+ i,:));
    Zx = [Zx com_Z];
    end
    Z = [Zx;Z];
end

%% 将列向量移到同一个高度上
for j = 1:N
    for i =1:N-1
        Z((npiex*i+1:npiex*(i+1)) , ((j -1)*npiex +1:npiex*j))=Z((npiex*i+1:npiex*(i+1)) , ((j -1)*npiex +1:npiex*j)) + sum(Z(npiex *i ,(j-1)*npiex + 1 : j * npiex) -Z(npiex*i + 1 ,(j-1)*npiex + 1 : j * npiex)) / npiex;
    end
end
 %% 将行向量移到同一个高度上
 for k =1:N-1
     Z(: , npiex * k +1 : npiex * ( k +1 )) =  Z(: , npiex * k +1 : npiex * ( k +1 )) + sum(Z(: , npiex * k) - Z(: , npiex * k + 1)) / size(Z , 1);
 end
%% 得到修正后拼接的图片
[X, Y]= meshgrid(linspace(-0.1,0.1,N*npiex) , linspace(-0.1,0.1,N*npiex));
figure()
surf(X,Y,Z,'FaceAlpha',0.5);
