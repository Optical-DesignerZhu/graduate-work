clear
N =20;% 分割像素点
num =1000; %生成的样本集的个数
Tra_A = zeros(num, N^2);
Tra_W = zeros(num, 2);
for k =1: num
    a= 5 * rand + 10;
    b= 5 * rand + 10;
    [ prx, pry] = Paraboloid(a, b);%读取所需的照片坐标点位置
    A = zeros(N,N);
    for i = 1:N
        for j =1:N
            A(i,j) = length(find(prx<=-5+(10*i)/N & prx> - 5+(10 * i - 10)/N & pry<=-5+(10 * j) / N & pry> - 5+(10 * j - 10) / N));%选择CCD的范围为-5 到 5
        end
    end
    Tra_A(k,:) = A(:)';
    Tra_W(k,:) = [a b];
end