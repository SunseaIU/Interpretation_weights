% example 1

clear all; close all;

x_2 = rand(100,1)*0.5;  % channel_2: noise
x_1 = [1+rand(50,1); 2+rand(50,1)] + x_2; % channel 1: signal_of_interest + noise

x_3 = x_1 - x_2;

X = [x_1, x_2]; 
figure;
plot(X(1:50,1),X(1:50,2),'r.'); % the former 50 points are #1 class
hold on
plot(X(51:100,1),X(51:100,2),'b.'); % the latter 50 points are #2 class
hold off

Y = [ones(50,1); 2*ones(50,1)];

%
XL = [X(1:25,:); X(51:75,:)];
XU = [X(26:50,:); X(76:100,:)];
YL = [[ones(25,1),zeros(25,1)];[zeros(25,1),ones(25,1)]];
YU = [ones(25,1);2*ones(25,1)];

ntr= 50;
ntt=50;

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

save RLSR_W_example1 W
