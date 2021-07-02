function [ prx, pry] = Paraboloid(a, b)
[X,Y] = meshgrid(-20:20,-20:20);
Z = (X.^2)/(a^2) + (Y.^2)/(b^2);
 surf(X,Y,Z,'FaceAlpha',0.5,'FaceColor','b');axis equal
 hold on
sx = -11:0.2:-1;
sy = -5:0.2:5;
[X,Y] = meshgrid(sx, sy);
X = X(:)';
Y = Y(:)';
sx =[X; X];
sy =[Y;Y];
Z1 = X.^2/a^2 +Y.^2/b^2 ;
sz = [ 20*ones(size(Z1)); Z1];
plot3(sx,sy,sz,'y')
I = [0 0 -1];
N = [(2*X)/a^2 ;(2*Y)/b^2 ;-1*ones(size(X))];
N = N./repmat(sqrt(sum(N.^2,1)),size(N,1),1);
R = repmat(I',1,size(N,2)) - 2 * repmat(I * N, 3, 1).*N;
Z2 = 20 * ones(size(Z1));
t = (20 - Z1)./R(3);
rx = [X;R(1,:) .* t + X];
ry = [Y;R(2,:) .*t  + Y];
rz = [Z1;Z2];
prx = R(1,:) .* t + X;
pry = R(2,:) .*t  + Y;
plot3(rx,ry,rz,'r')

 
