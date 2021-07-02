clear
frame =20;
for i = 1:frame
[X,Y] = meshgrid(-20:20,-20:20);
a=7;
b=7;
Z = (X.^2)/(a^2) + (Y.^2)/(b^2);
figure()
surf(X,Y,Z,'FaceAlpha',0.5,'FaceColor','b');axis equal
hold on
sx = -11:0.5:-7;
sy = -5:0.5:-1;
[X,Y] = meshgrid(sx, sy);
X = X(:)';
Y = Y(:)';
sx =[X; X];
sy =[Y;Y];
Z1 = X.^2/a^2 +Y.^2/b^2 ;
p =  20*ones(size(Z1)) + (Z1 -  20*ones(size(Z1)))*i/frame;
sz = [ 20*ones(size(Z1)); p];
plot3(sx,sy,sz,'y')
    set(gca,'XLim',[-10 10],'YLim',[-15 15],'ZLim',[0 20]);
    %保存图片，位置为:/image，名称为i.bmp
    print('-dbmp',sprintf('image%d',i))
    %关闭figure()
    close;
end
I = [0 0 -1];
N = [(2*X)/a^2 ;(2*Y)/b^2 ;-1*ones(size(X))];
N = N./repmat(sqrt(sum(N.^2,1)),size(N,1),1);
R = repmat(I',1,size(N,2)) - 2 * repmat(I * N, 3, 1).*N;
%%
for i= frame +1:2*frame
[fX,fY] = meshgrid(-20:20,-20:20);
a=7;
b=7;
fZ = (fX.^2)/(a^2) + (fY.^2)/(b^2);
figure()
surf(fX,fY,fZ,'FaceAlpha',0.5,'FaceColor','b');axis equal
hold on
sx =[X; X];
sy =[Y;Y];
Z1 = X.^2/a^2 +Y.^2/b^2 ;
sz = [ 20*ones(size(Z1)); Z1];
plot3(sx,sy,sz,'y')
h = Z1 + (20 - Z1)*(i - frame)/frame;
Z2 = h .* ones(size(Z1));
t = (h - Z1)./R(3);
rx = [X;R(1,:) .* t + X];
ry = [Y;R(2,:) .*t  + Y];
rz = [Z1;Z2];
prx = R(1,:) .* t + X;
pry = R(2,:) .*t  + Y;
plot3(rx,ry,rz,'r')
        axis equal;
    set(gca,'XLim',[-10 10],'YLim',[-15 15],'ZLim',[0 20]);
    %保存图片，位置为:/image，名称为i.bmp
    print('-dbmp',sprintf('image%d',i))
    %关闭figure()
    close;
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
