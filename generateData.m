clear all;

mu_pos = [1.5,0]';
mu_neg = [-1.5,0]';
sigma = [1.02, -0.30; -0.30, 0.15];

X_pos = mvnrnd(mu_pos, sigma, 100);
X_neg = mvnrnd(mu_neg, sigma, 100);

figure;
plot(X_pos(:,1),X_pos(:,2),'r.');
hold on
plot(X_neg(:,1),X_neg(:,2),'b.');

XL = [X_pos(1:50,:); X_neg(1:50,:)]; YL = [[ones(50,1);zeros(50,1)],[zeros(50,1);ones(50,1)]];
XU = [X_pos(51:100,:); X_neg(51:100,:)]; YU = [[ones(50,1);zeros(50,1)],[zeros(50,1);ones(50,1)]];
save XL XL
save XU XU
save YL YL
save YU YU