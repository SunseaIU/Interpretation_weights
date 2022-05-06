% LDA

clear;

load XL 
load XU
load YL
load YU

X = [XL; XU];
Y = [YL; YU]; % n-by-c form
[~, Y] =  max(Y,[],2);  % vector

options = [];


[eigvector, eigvalue] = LDA(Y, options, X);

save LDA_eigvector eigvector