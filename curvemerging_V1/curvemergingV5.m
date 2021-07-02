clear
load initialW
W = initialW(1,:);
piexN =100;                                                            % �ָ����ص�
N =20;                                                                        %�����򱻻��ֵ�������
h = 0.6;                                                                    %��Դ�ĸ߶�
L = 2;                                                                        %������Ĵ�С 

x =2* linspace(-(2 * N - 1) / (10 * N),(2 * N - 1) /  (10 * N),2 * N);
y =2* linspace(-(2 * N - 1) / (10 * N ),(2 * N - 1) / (10 * N),2 * N);
X = meshgrid(x);
Y = rot90(meshgrid(y),1);
PreA = zeros(N^2,10000);
rangeX = zeros(N^2,2);
rangeY  = zeros(N^2,2);
    for i = 1:N
        for j =1:N
            temp_rangeX = [X(i  ,j + N) , X(i + N ,j )];
            temp_rangeY = [Y(i ,j + N) , Y(i + N ,j )];
            rangeX((i - 1) * N + j,:) =  temp_rangeX;
            rangeY((i - 1) * N + j,:) =  temp_rangeY;
            preA= curvemergingRayTrace( W , rangeX((i - 1) * N + j,:) , rangeY((i - 1) * N + j,:),piexN,h,L);
            PreA((i - 1) * N + j,:) =preA(:)';
            k = ( i - 1) * N + j
        end
    end
%%  д������
csvwrite('C:\Users\Administrator\tf1\preA.csv',PreA);
%% ��ȡѵ����ɺ�Ԥ��ĸ���Ȩ��ϵ��
load('C:\Users\Administrator\tf1\preW.mat');%����Ԥ��õ���zernike�����ϵ��
preW = array;
%% �õ�ƴ�Ӻ��ԭʼͼƬ
npiex = 8;
Z = [];
expandX = [0.2/N, -0.2/N] ;
expandY = [0.2/N, -0.2/N] ;
for j = 1:N
    Zx =[];
    for i =1:N
    [~,~,com_Z] = showrebuild(preW((j -1)*N+ i,:), expandX, expandY, npiex);
    Zx = [Zx com_Z];
    end
    Z = [Zx;Z];
end
%% ����Z������
[~,~,molZ] = modifyZ(initialW(1,:),N);
for i = 1:N
    for j =1:N
        Z(2 * npiex * (i - 1) +1 : 2*npiex * i , 2 * npiex* (j - 1) + 1:2 * npiex * j) =Z(2*npiex * (i - 1) +1 :2*npiex * i, 2 * npiex* (j - 1) + 1:2 *npiex * j) - (Z(2*npiex * (i -1) +npiex,2 * npiex * (j - 1) +npiex) - molZ(i, j));
    end
end
%% ƽ������
t = linspace(0,1,npiex);
for  k = 1:N
for j = 1:N-1
    for i = 1:npiex
        mergePoint(2*(k-1)*npiex + 1:2*k*npiex,npiex*(j -1) +i) =(1 - t(i)) * Z(2*(k-1)*npiex + 1:2*k*npiex, npiex+(j-1) *2*npiex +i) + t(i) *Z(2*(k-1)*npiex + 1:2*k*npiex, 2*npiex + (j - 1) * 2*npiex+i);
    end
end
end

for j =1:N-1
    for i = 1:npiex
       finalmerge(npiex*(j -1) +i,:) = (1 - t(i)) * mergePoint(2*npiex*(j - 1) + npiex + i, :) + t(i) * mergePoint(2*npiex*j +i,:);
    end
end


[X, Y]= meshgrid(linspace(-0.2,0.2,npiex*(N-1)) , linspace(-0.2,0.2,npiex*(N-1)));
finalmerge = 10*finalmerge;
X = 10*X;
Y = 10*Y;
figure()
surf(X,Y,finalmerge,'FaceAlpha',0.5);
xlabel('mm')
ylabel('mm')
zlabel('mm')

%% ��Zernike����ʽ��ϵõ��ĵ���

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
[X, Y]= meshgrid(linspace(-0.2,0.2,160) , linspace(-0.2,0.2,160));
Z = 10*Z;
X = 10*X;
Y = 10*Y;
figure()
surf(X,Y,Z,'FaceAlpha',0.5);
xlabel('mm')
ylabel('mm')
zlabel('mm')