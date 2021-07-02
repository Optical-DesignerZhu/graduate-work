function com_Z= showh( W ,rangeX , rangeY)
[X,Y] = meshgrid(linspace(rangeX(2),rangeX(1),11) , linspace(rangeY(2),rangeY(1),11) );
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
surf(X,Y,com_Z,'FaceAlpha',0.5);
axis equal
end

