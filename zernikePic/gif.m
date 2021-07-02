clear
frame = 20;
W = rand(1,15);
W = W/norm(W);
for i =1:frame
%   W为zernike前15项中每一项所占的比重
[X,Y] = meshgrid(-0.5:0.01:0.5,-0.5:0.01:0.5);
Z(:,:,1) = ones(size(X));
Z(:,:,2) = Y;
Z(:,:,4)= (2.*X .* Y);
Z(:,:,3) = X;
Z(:,:,5)= -1 + 2 * X.^2 + 2 * Y.^2;
Z(:,:,6)= X.^2 - Y.^2;
Z(:,:,7) = 3 * X.^2.*Y - Y.^3;
Z(:,:,8) = -2.* Y + 3 * Y .*(X.^2 + Y.^2);
Z(:,:,9)= -2 * X + 3 * X .* (X.^2 + Y.^2);
Z(:,:,10)= X.^3 - 3 * X .* Y.^2;
Z(:,:,11) = 4 * X.^3.* Y - 4 *X  .* Y.^3;
Z(:,:,12) = -6 * X .* Y + 8 * X .* Y .* (X.^2 + Y.^2);
Z(:,:,13)= 1 - 6 *  (X.^2 + Y.^2) +  6 * (X.^2 + Y.^2).^2;
Z(:,:,14) = -3 * X.^2 + 3* Y.^2 + 4 * X.^4 - 4 *Y.^4;
Z(:,:,15) = X.^4 - 6 * X.^2 .*Y.^2 + Y.^4;
%% 画出组合后的zernike多项式的曲面
com_Z = W(1) * (Z(:,:,1)) + W(2) * (Z(:,:,2)) + W(3) * (Z(:,:,3)) + W(4) * (Z(:,:,4)) + W(5) * (Z(:,:,5)) + W(6) * (Z(:,:,6)) + W(7) * (Z(:,:,7))...
    + W(8) * (Z(:,:,8)) + W(9) * (Z(:,:,9)) + W(10) * (Z(:,:,10)) + W(11) * (Z(:,:,11)) + W(12) * (Z(:,:,12)) + W(13) * (Z(:,:,13)) + W(14) * (Z(:,:,14)) + W(15) * (Z(:,:,15));
figure()
surf(X,Y,com_Z,'FaceAlpha',0.5);
axis equal
hold on                                                             
sx =-0.1:0.02:0.1;                                        %光源X轴的取值范围
sy = -0.1:0.02:0.1;                                       %光源Y轴的取值范围
[X,Y] = meshgrid(sx, sy);
X = X(:)';
Y = Y(:)';
sx =[X; X];
sy =[Y;Y];
Z1(:,:,1) = ones(size(X));
Z1(:,:,2) = Y;
Z1(:,:,3) = X;
Z1(:,:,4)= (2.*X .* Y);
Z1(:,:,5)= -1 + 2 * X.^2 + 2 * Y.^2;
Z1(:,:,6)= X.^2 - Y.^2;
Z1(:,:,7) = 3 * X.^2.*Y - Y.^3;
Z1(:,:,8) = -2.* Y + 3 * Y .*(X.^2 + Y.^2);
Z1(:,:,9)= -2 * X + 3 * X .* (X.^2 + Y.^2);
Z1(:,:,10)= X.^3 - 3 * X .* Y.^2;
Z1(:,:,11) = 4 * X.^3.* Y - 4 *X  .* Y.^3;
Z1(:,:,12) = -6 * X .* Y + 8 * X .* Y .* (X.^2 + Y.^2);
Z1(:,:,13)= 1 - 6 *  (X.^2 + Y.^2) +  6 * (X.^2 + Y.^2).^2;
Z1(:,:,14) = -3 * X.^2 + 3* Y.^2 + 4 * X.^4 - 4 *Y.^4;
Z1(:,:,15) = X.^4 - 6 * X.^2 .*Y.^2 + Y.^4;
com_Z1 = W(1) * (Z1(:,:,1)) + W(2) * (Z1(:,:,2)) + W(3) * (Z1(:,:,3)) + W(4) * (Z1(:,:,4)) + W(5) * (Z1(:,:,5)) + W(6) * (Z1(:,:,6)) + W(7) * (Z1(:,:,7))...
    + W(8) * (Z1(:,:,8)) + W(9) * (Z1(:,:,9)) + W(10) * (Z1(:,:,10)) + W(11) * (Z1(:,:,11)) + W(12) * (Z1(:,:,12)) + W(13) * (Z1(:,:,13)) + W(14) * (Z1(:,:,14)) + W(15) * (Z1(:,:,15));
com_Z1  = com_Z1 (:)';


p =  0.6*ones(size(com_Z1)) + (com_Z1 - 0.6*ones(size(com_Z1))) * i /frame; 
sz = [ 0.6*ones(size(com_Z1)); p];
plot3(sx,sy,sz,'y')
set(gca,'XLim',[-0.6 0.6],'YLim',[-0.6 0.6],'ZLim',[-0.5 0.6]);
    %保存图片，位置为:/image，名称为i.bmp
    print('-dbmp',sprintf('image%d',i))
    %关闭figure()
    close;
end
%% 求出照射点位置处的法线向量以及出射光线方向向量
for i = frame + 1:2 * frame
    [fX,fY] = meshgrid(-0.5:0.01:0.5,-0.5:0.01:0.5);
figure()
 surf(fX,fY,com_Z,'FaceAlpha',0.5);
axis equal
hold on 
sz = [ 0.6*ones(size(com_Z1)); com_Z1];
plot3(sx,sy,sz,'y')
I = [0 0 -1];                                                      %入射光线向量
der_X(:,:,1) = zeros(size(X));                         %Zernike每一项关于X的偏导
der_X(:,:,2) = zeros(size(X));
der_X(:,:,3) = ones(size(X));
der_X(:,:,4) = 2 * Y;
der_X(:,:,5) = 4 * X;
der_X(:,:,6) = 2 * X;
der_X(:,:,7) = 6 .* X .* Y;
der_X(:,:,8) = 6 .* X .* Y;
der_X(:,:,9) = - 2 + 9 * X.^2 + 3 * Y.^2;
der_X(:,:,10) = 3 * X.^2 - 3 * Y.^2;
der_X(:,:,11) = 12 * X.^2 .* Y - 4 * Y.^3;
der_X(:,:,12) = - 6 * Y +24 * X.^2 .* Y + 8 * Y.^3;
der_X(:,:,13) = - 12 * X + 24 * X.^3 + 24 * X .* Y.^2;
der_X(:,:,14) = - 6 * X + 16 * X.^3;
der_X(:,:,15) = 4 * X.^3 - 12 * X .* Y.^2;
                              
der_Y(:,:,1) = zeros(size(X));                         %Zernike每一项关于Y的偏导
der_Y(:,:,2) = ones(size(X));
der_Y(:,:,3) = zeros(size(X));
der_Y(:,:,4) = 2 * X;
der_Y(:,:,5) = 4 * Y;
der_Y(:,:,6) = - 2 *Y;
der_Y(:,:,7) = 3 * X.^2 - 3 * Y.^2;
der_Y(:,:,8) = -2 + 3 *X.^2 + 9 * Y.^2;
der_Y(:,:,9) = 6 *X .* Y;
der_Y(:,:,10) = - 6 *X .* Y;
der_Y(:,:,11) = 4 * X .^3 - 12 * X .* Y .^2;
der_Y(:,:,12) = - 6 * X + 8 * X.^3 + 24 .* X .* Y .^2; 
der_Y(:,:,13) = - 12 * Y + 24 * X.^2 .*Y + 24 * Y .^3;
der_Y(:,:,14) = 6 * Y - 16 * Y.^3;
der_Y(:,:,15) = -12 * X.^2 .* Y + 4 * Y.^3;

derCom_X = W(1) * der_X(:,:,1)+ W(2) * der_X(:,:,2) + W(3) * der_X(:,:,3) + W(4) * der_X(:,:,4) + W(5) * der_X(:,:,5) + W(6) * der_X(:,:,6) + W(7) * der_X(:,:,7)...
    + W(8) * der_X(:,:,8) + W(9) * der_X(:,:,9) + W(10) * der_X(:,:,10) + W(11) * der_X(:,:,11) + W(12) * der_X(:,:,12) + W(13) * der_X(:,:,13) + W(14) * der_X(:,:,14) + W(15) * der_X(:,:,15);
derCom_Y = W(1) * der_Y(:,:,1)+ W(2) * der_Y(:,:,2) + W(3) * der_Y(:,:,3) + W(4) * der_Y(:,:,4) + W(5) * der_Y(:,:,5) + W(6) * der_Y(:,:,6) + W(7) * der_Y(:,:,7)...
    + W(8) * der_Y(:,:,8) + W(9) * der_Y(:,:,9) + W(10) * der_Y(:,:,10) + W(11) * der_Y(:,:,11) + W(12) * der_Y(:,:,12) + W(13) * der_Y(:,:,13) + W(14) * der_Y(:,:,14) + W(15) * der_Y(:,:,15);
N = [derCom_X; derCom_Y; - 1 *ones(size(derCom_X))];%光线与自由曲面交点的法线方向的单位向量
R = repmat(I',1,size(N,2)) - 2 * repmat(I * N, 3, 1).*N;      %反射光线的单位向量
h = com_Z1 +(0.6 - com_Z1)*(i - frame)/frame;
t = (h - com_Z1) ./ R(3,:);
rx = [X;R(1,:) .* t+ X];
ry = [Y;R(2,:) .*t + Y];
rz = [com_Z1;h];
plot3(rx,ry,rz,'r') 
set(gca,'XLim',[-0.6 0.6],'YLim',[-0.6 0.6],'ZLim',[-0.5 0.6]);
 print('-dbmp',sprintf('image%d',i))
prx = R(1,:) .* t+ X;                                        %在CCD上的x轴取值
pry = R(2,:) .*t + Y;                                        %在CCD上的y轴取值
close;
 %关闭figure()
end
%%
for j=1:2*frame
    %获取当前图片
    A=imread(sprintf('image%d.bmp',j));
    [I,map]=rgb2ind(A,256);
    %生成gif，并保存
    if(j==1)
        imwrite(I,map,'movefig.gif','DelayTime',0.1,'LoopCount',Inf)
    else
        imwrite(I,map,'movefig.gif','WriteMode','append','DelayTime',0.1)    
    end
end

