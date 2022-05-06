clear ; close all

load XL
load XU
load YL
load YU
ntr = 100;
ntt = 100;


figure;
plot(XL(1:50,1),XL(1:50,2),'r.');
hold on
plot(XU(1:50,1),XU(1:50,2),'r.');
hold on
plot(XL(51:100,1),XL(51:100,2),'b.');
hold on
plot(XU(51:100,1),XU(51:100,2),'b.');

p = 1;
maxIter = 50;
gammalib = 2.^(-10:10);

XL = XL';
XU = XU';

[~,YU] = max(YU,[],2);


acc_RLSR = zeros(length(gammalib),1);
for i = 1:length(gammalib)
    gamma = gammalib(i);
    
    % function
    [~, theta, W,  obj, Y] = RLSR(XL, YL, XU, p, gamma, maxIter);
    
    % accuracy
    [~,YU_pred] = max(Y(ntr+1:ntr+ntt,:),[],2);
    acc_RLSR(i,1) = length(find(YU_pred == YU))./ntt;
    fprintf('gamma = %d, accuracy = %.2f \n', log2(gamma), acc_RLSR(i,1)*100);
end
fprintf('The max accuracy = %.2f\n',max(acc_RLSR(:))*100);

save RLSR_W_example2 W