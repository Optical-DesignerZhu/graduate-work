clear
N =20;% �ָ����ص�
num =1000; %���ɵ��������ĸ���
Tra_A = zeros(num, N^2);
Tra_W = zeros(num, 2);
for k =1: num
    a= 5 * rand + 10;
    b= 5 * rand + 10;
    [ prx, pry] = Paraboloid(a, b);%��ȡ�������Ƭ�����λ��
    A = zeros(N,N);
    for i = 1:N
        for j =1:N
            A(i,j) = length(find(prx<=-5+(10*i)/N & prx> - 5+(10 * i - 10)/N & pry<=-5+(10 * j) / N & pry> - 5+(10 * j - 10) / N));%ѡ��CCD�ķ�ΧΪ-5 �� 5
        end
    end
    Tra_A(k,:) = A(:)';
    Tra_W(k,:) = [a b];
end