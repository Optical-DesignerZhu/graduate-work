clear
load Tra_A51
load Tra_W51
%% 取出受到光照相应位置的照度图片
A_begin = reshape(Tra_A51 , [100,100]);                %还原为原图的尺寸
W = Tra_W51;                                                 %初始化权重指标
S1 = sum(A_begin,2);                                                  %按行求和
ind1 = find(S1>0);                                          %找出存在光照的行范围
S2 = sum(A_begin,1);                                                %按列求和
ind2 = find(S2>0);                                         %找出存在光照的列范围
A1_begin = A_begin(ind1(1):ind1(end) , ind2(1):ind2(end));%将光照部分图像取出
imagesc(A1_begin);                                                     %# Create a colored plot of the matrix values
colormap(flipud(gray));
axis equal
lambda = 0.1;
white =length( find(A1_begin ==0));
S = (ind1(end) - ind1(1) + 1) * (ind2(end) - ind2(1) + 1); %求出光照的矩形面积
aveLight = sum(S1) / S;                                %求出光照的平均值
aveLight = aveLight * ones(size(A1_begin));
RMS_error =sqrt(sum( sum( (A1_begin - aveLight) .* (A1_begin - aveLight) ) ) / S) + lambda * white; %求出光照均方差误差
RMS_errorNew =RMS_error ;
%% 进行迭代计算使得光照分布尽可能均匀
number = 1;
delta = 0;
for n =1:5
    for k = 1:15
        F = 1;
        while((RMS_errorNew - RMS_error<=0 ||  k<=15) && F ==1)
            W(k) = W(k) + 0.0009;
            W =  W / norm(W);                                    %归一化权重指标
            [rx, ry] = zernikecomb( W);                       %读取所需的照片坐标点位置
            N = 100;
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
            A1 = A(ind1(1):ind1(end) , ind2(1):ind2(end));%将光照部分图像取出
            white =length( find(A1 ==0));
            S = (ind1(end) - ind1(1) + 1) * (ind2(end) - ind2(1) + 1); %求出光照的矩形面积
            aveLight = sum(S1) / S;                                %求出光照的平均值
            aveLight = aveLight * ones(size(A1));
            RMS_errorNew =sqrt(sum( sum( (A1 - aveLight) .* (A1 - aveLight) ) ) / S) + lambda * white; %求出光照均方差误差
            if RMS_errorNew <=RMS_error
                flag = 0;
            end
            if RMS_errorNew >RMS_error
                flag = 1;
            end
            %%
            W(k) = W(k) - 0.0009;
            while(F)
                W(k) = W(k) + 0.0009;
                W =  W / norm(W);                                    %归一化权重指标
                [rx, ry] = zernikecomb( W);                       %读取所需的照片坐标点位置
                N = 100;
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
                A1 = A(ind1(1):ind1(end) , ind2(1):ind2(end));%将光照部分图像取出
                white =length( find(A1 ==0));
                S = (ind1(end) - ind1(1) + 1) * (ind2(end) - ind2(1) + 1); %求出光照的矩形面积
                aveLight = sum(S1) / S;                                %求出光照的平均值
                aveLight = aveLight * ones(size(A1));
                RMS_errorNew =sqrt(sum( sum( (A1 - aveLight) .* (A1 - aveLight) ) ) / S) + lambda * white; %求出光照均方差误差
                if (RMS_errorNew - RMS_error) <=0 && flag ==0
                    RMS_error = RMS_errorNew;
                    ANew = A;
                end
                
                if (RMS_errorNew - RMS_error) >0 && flag ==0
                    W(k) = W(k) - 0.0009;
                    break
                end
                
                %%
                if (RMS_errorNew - RMS_error) >0 &&  flag ==1
                    W(k) = W(k) - 0.0009;
                    while(1)
                        W(k) = W(k) - 0.0009;
                        W =  W / norm(W);                                    %归一化权重指标
                        [rx, ry] = zernikecomb( W);                       %读取所需的照片坐标点位置
                        N = 100;
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
                        A1 = A(ind1(1):ind1(end) , ind2(1):ind2(end));%将光照部分图像取出
                        white =length( find(A1 ==0));
                        S = (ind1(end) - ind1(1) + 1) * (ind2(end) - ind2(1) + 1); %求出光照的矩形面积
                        aveLight = sum(S1) / S;                                %求出光照的平均值
                        aveLight = aveLight * ones(size(A1));
                        RMS_errorNew =sqrt(sum( sum( (A1 - aveLight) .* (A1 - aveLight) ) ) / S) + lambda * white; %求出光照均方差误差
                        if (RMS_errorNew - RMS_error) <=0
                            RMS_error = RMS_errorNew;
                            ANew = A;
                        end
                        if (RMS_errorNew - RMS_error) >0 && flag == 1
                            W(k) = W(k) + 0.0009;
                            F = 0;
                            break
                        end
                    end
                end
            end
        end
    end
    n
end



figure()
imagesc(ANew);                                                     %# Create a colored plot of the matrix values
colormap(flipud(gray));
axis equal