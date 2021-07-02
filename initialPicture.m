clear
lambda = 0.1;
N = 100;
initialPic = zeros(10,N^2);
initialW = zeros(10,15);
for k = 1:10
RMS_error =1000;
while(RMS_error>18)
W = rand(1,15);                                               %随机生成权重取值
W =  W / norm(W);                                        %归一化权重指标
[rx, ry] = zernikecomb( W);                          %读取所需的照片坐标点位置
A = zeros(N,N);         
for i = 1:N
    for j =1:N
        A(i,j) = length(find(rx<=-2+(4*i)/N ...%选择CCD的范围为-2到2
            & rx> - 2+(4*i - 4)/N & ry<=-2+(4*j)/N & ry>-2+(4*j - 4)/N));
    end
end
S1 = sum(A,2);                                                  %按行求和
ind1 = find(S1>0);                                          %找出存在光照的行范围
S2 = sum(A,1);                                                %按列求和
ind2 = find(S2>0);                                         %找出存在光照的列范围
A1_begin = A(ind1(1):ind1(end) , ind2(1):ind2(end));%将光照部分图像取出
white =length( find(A1_begin ==0));
S = (ind1(end) - ind1(1) + 1) * (ind2(end) - ind2(1) + 1); %求出光照的矩形面积
aveLight = sum(S1) / S;                                %求出光照的平均值
aveLight = aveLight * ones(size(A1_begin));
RMS_error =sqrt(sum( sum( (A1_begin - aveLight) .* (A1_begin - aveLight) ) ) / S) + lambda * white; %求出光照均方差误差
end
initialPic(k,:) = A(:)';
initialW(k,:) = W(:)';
k
end
displayData(initialPic)
% for i=1:10
%     figure()
%     showrebuild(initialW(i,:));
% end

