clear
load initialW.mat
[rx, ry] = zernikeComb(initialW);                          %��ȡ�������Ƭ�����λ��
N = 100;
initialPic = zeros(N,N);         
for i = 1:N
    for j =1:N
        initialPic(i,j) = length(find(rx<=-2+(4*i)/N ...%ѡ��CCD�ķ�ΧΪ-2��2
            & rx> - 2+(4*i - 4)/N & ry<=-2+(4*j)/N & ry>-2+(4*j - 4)/N));
    end
end
%% ȡ���ܵ�������Ӧλ�õ��ն�ͼƬ
A_begin = initialPic;
W = initialW;                                                 %��ʼ��Ȩ��ָ��
S1 = sum(A_begin,2);                                                  %�������
ind1 = find(S1>0);                                          %�ҳ����ڹ��յ��з�Χ
S2 = sum(A_begin,1);                                                %�������
ind2 = find(S2>0);                                         %�ҳ����ڹ��յ��з�Χ
A1_begin = A_begin(ind1(1):ind1(end) , ind2(1):ind2(end));%�����ղ���ͼ��ȡ��
imagesc(A1_begin);                                                     %# Create a colored plot of the matrix values
colormap(flipud(gray));
axis equal
lambda = 0.1;
white =length( find(A1_begin ==0));
S = (ind1(end) - ind1(1) + 1) * (ind2(end) - ind2(1) + 1); %������յľ������
aveLight = sum(S1) / S;                                %������յ�ƽ��ֵ
aveLight = aveLight * ones(size(A1_begin));
RMS_error =sqrt(sum( sum( (A1_begin - aveLight) .* (A1_begin - aveLight) ) ) / S) + lambda * white; %������վ��������
RMS_errorNew =RMS_error ;
%% ���е�������ʹ�ù��շֲ������ܾ���
delta = 0.0015;
for n =1:7
    for k = 1:15
        F = 1;
        while((RMS_errorNew - RMS_error<=0 ||  k<=15) && F ==1)
            W(k) = W(k) + delta;
            W =  W / norm(W);                                    %��һ��Ȩ��ָ��
            [rx, ry] = zernikeComb( W);                       %��ȡ�������Ƭ�����λ��
            N = 100;
            A = zeros(N,N);
            for i = 1:N
                for j =1:N
                    A(i,j) = length(find(rx<=-2+(4*i)/N ...%ѡ��CCD�ķ�ΧΪ-2��2
                        & rx> - 2+(4*i - 4)/N & ry<=-2+(4*j)/N & ry>-2+(4*j - 4)/N));
                end
            end
            S1 = sum(A,2);                                                  %�������
            ind1 = find(S1>0);                                          %�ҳ����ڹ��յ��з�Χ
            S2 = sum(A,1);                                                %�������
            ind2 = find(S2>0);                                         %�ҳ����ڹ��յ��з�Χ
            A1 = A(ind1(1):ind1(end) , ind2(1):ind2(end));%�����ղ���ͼ��ȡ��
            white =length( find(A1 ==0));
            S = (ind1(end) - ind1(1) + 1) * (ind2(end) - ind2(1) + 1); %������յľ������
            aveLight = sum(S1) / S;                                %������յ�ƽ��ֵ
            aveLight = aveLight * ones(size(A1));
            RMS_errorNew =sqrt(sum( sum( (A1 - aveLight) .* (A1 - aveLight) ) ) / S) + lambda * white; %������վ��������
            if RMS_errorNew <=RMS_error
                flag = 0;
            end
            if RMS_errorNew >RMS_error
                flag = 1;
            end
            %%
            W(k) = W(k) - delta;
            while(F)
                W(k) = W(k) + delta;
                W =  W / norm(W);                                    %��һ��Ȩ��ָ��
                [rx, ry] = zernikeComb( W);                       %��ȡ�������Ƭ�����λ��
                N = 100;
                A = zeros(N,N);
                for i = 1:N
                    for j =1:N
                        A(i,j) = length(find(rx<=-2+(4*i)/N ...%ѡ��CCD�ķ�ΧΪ-2��2
                            & rx> - 2+(4*i - 4)/N & ry<=-2+(4*j)/N & ry>-2+(4*j - 4)/N));
                    end
                end
                S1 = sum(A,2);                                                  %�������
                ind1 = find(S1>0);                                          %�ҳ����ڹ��յ��з�Χ
                S2 = sum(A,1);                                                %�������
                ind2 = find(S2>0);                                         %�ҳ����ڹ��յ��з�Χ
                A1 = A(ind1(1):ind1(end) , ind2(1):ind2(end));%�����ղ���ͼ��ȡ��
                white =length( find(A1 ==0));
                S = (ind1(end) - ind1(1) + 1) * (ind2(end) - ind2(1) + 1); %������յľ������
                aveLight = sum(S1) / S;                                %������յ�ƽ��ֵ
                aveLight = aveLight * ones(size(A1));
                RMS_errorNew =sqrt(sum( sum( (A1 - aveLight) .* (A1 - aveLight) ) ) / S) + lambda * white; %������վ��������
                if (RMS_errorNew - RMS_error) <=0 && flag ==0
                    RMS_error = RMS_errorNew;
                    ANew = A;
                end
                
                if (RMS_errorNew - RMS_error) >0 && flag ==0
                    W(k) = W(k) - delta;
                    break
                end
                
                %%
                if (RMS_errorNew - RMS_error) >0 &&  flag ==1
                    W(k) = W(k) - delta;
                    while(1)
                        W(k) = W(k) - delta;
                        W =  W / norm(W);                                    %��һ��Ȩ��ָ��
                        [rx, ry] = zernikeComb( W);                       %��ȡ�������Ƭ�����λ��
                        N = 100;
                        A = zeros(N,N);
                        for i = 1:N
                            for j =1:N
                                A(i,j) = length(find(rx<=-2+(4*i)/N ...%ѡ��CCD�ķ�ΧΪ-2��2
                                    & rx> - 2+(4*i - 4)/N & ry<=-2+(4*j)/N & ry>-2+(4*j - 4)/N));
                            end
                        end
                        S1 = sum(A,2);                                                  %�������
                        ind1 = find(S1>0);                                          %�ҳ����ڹ��յ��з�Χ
                        S2 = sum(A,1);                                                %�������
                        ind2 = find(S2>0);                                         %�ҳ����ڹ��յ��з�Χ
                        A1 = A(ind1(1):ind1(end) , ind2(1):ind2(end));%�����ղ���ͼ��ȡ��
                        white =length( find(A1 ==0));
                        S = (ind1(end) - ind1(1) + 1) * (ind2(end) - ind2(1) + 1); %������յľ������
                        aveLight = sum(S1) / S;                                %������յ�ƽ��ֵ
                        aveLight = aveLight * ones(size(A1));
                        RMS_errorNew =sqrt(sum( sum( (A1 - aveLight) .* (A1 - aveLight) ) ) / S) + lambda * white; %������վ��������
                        if (RMS_errorNew - RMS_error) <=0
                            RMS_error = RMS_errorNew;
                            ANew = A;
                        end
                        if (RMS_errorNew - RMS_error) >0 && flag == 1
                            W(k) = W(k) + delta;
                            F = 0;
                            break
                        end
                    end
                end
            end
        end
    end
    n
   error(n) =  RMS_error;
end
figure()
plot(error)


S1 = sum(ANew,2);                                                  %�������
ind1 = find(S1>0);                                          %�ҳ����ڹ��յ��з�Χ
S2 = sum(ANew,1);                                                %�������
ind2 = find(S2>0);                                         %�ҳ����ڹ��յ��з�Χ
ANew = ANew(ind1(1):ind1(end) , ind2(1):ind2(end));%�����ղ���ͼ��ȡ��
figure()
imagesc(ANew);                                                     %# Create a colored plot of the matrix values
colormap(flipud(gray));
axis equal