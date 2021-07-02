clear
load initialW
W = initialW(1,:);
piexN =100;                                                            % �ָ����ص�
N =10;                                                                        %�����򱻻��ֵ�������
h = 0.6;                                                                    %��Դ�ĸ߶�
L = 2;                                                                        %������Ĵ�С 

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
%% д������
csvwrite('C:\Users\Administrator\tf1\preA.csv',PreA);
%% ��ȡѵ����ɺ�Ԥ��ĸ���Ȩ��ϵ��
load('C:\Users\Administrator\tf1\preW.mat');%����Ԥ��õ���zernike�����ϵ��
preW = array;
%% �õ�ƴ�Ӻ��ԭʼͼƬ
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

%% ���������Ƶ�ͬһ���߶���
for j = 1:N
    for i =1:N-1
        Z((npiex*i+1:npiex*(i+1)) , ((j -1)*npiex +1:npiex*j))=Z((npiex*i+1:npiex*(i+1)) , ((j -1)*npiex +1:npiex*j)) + sum(Z(npiex *i ,(j-1)*npiex + 1 : j * npiex) -Z(npiex*i + 1 ,(j-1)*npiex + 1 : j * npiex)) / npiex;
    end
end
 %% ���������Ƶ�ͬһ���߶���
 for k =1:N-1
     Z(: , npiex * k +1 : npiex * ( k +1 )) =  Z(: , npiex * k +1 : npiex * ( k +1 )) + sum(Z(: , npiex * k) - Z(: , npiex * k + 1)) / size(Z , 1);
 end
%% �õ�������ƴ�ӵ�ͼƬ
[X, Y]= meshgrid(linspace(-0.1,0.1,N*npiex) , linspace(-0.1,0.1,N*npiex));
figure()
surf(X,Y,Z,'FaceAlpha',0.5);
