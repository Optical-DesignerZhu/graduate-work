function [ rx, ry] = ray( a,b )
sx = 5:0.1:9;
sy = 4:0.1:8;
[X,Y] = meshgrid(sx, sy);
X = X(:)';
Y = Y(:)';
Z1 = X.^2/a^2 +Y.^2/b^2 ;
I = [0 0 -1];
N = [(2*X)/a^2 ;(2*Y)/b^2 ;-1*ones(size(X))];
N = N./repmat(sqrt(sum(N.^2,1)),size(N,1),1);
R = repmat(I',1,size(N,2)) - 2 * repmat(I * N, 3, 1).*N;
t = (20 - Z1)./R(3);
rx =R(1,:) .* t + X;
ry =R(2,:) .*t  + Y;
end

