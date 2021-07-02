clear
lambda = 0.1;
N = 100;
initialPic = zeros(10,N^2);
initialW = zeros(10,15);
for k = 1:10
RMS_error =1000;
while(RMS_error>18)
W = rand(1,15);                                               %�������Ȩ��ȡֵ
W =  W / norm(W);                                        %��һ��Ȩ��ָ��
[rx, ry] = zernikecomb( W);                          %��ȡ�������Ƭ�����λ��
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
A1_begin = A(ind1(1):ind1(end) , ind2(1):ind2(end));%�����ղ���ͼ��ȡ��
white =length( find(A1_begin ==0));
S = (ind1(end) - ind1(1) + 1) * (ind2(end) - ind2(1) + 1); %������յľ������
aveLight = sum(S1) / S;                                %������յ�ƽ��ֵ
aveLight = aveLight * ones(size(A1_begin));
RMS_error =sqrt(sum( sum( (A1_begin - aveLight) .* (A1_begin - aveLight) ) ) / S) + lambda * white; %������վ��������
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

