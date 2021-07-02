a = textread('modify.txt');
a(:,end) = [];
b =  textread('original.txt');
b(:,end) = [];
sum(sum(abs(a - b)))/(128*128)
