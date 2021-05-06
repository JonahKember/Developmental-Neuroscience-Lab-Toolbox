function [beta,R2] = LASSO(X,Y,k,rep)
%
%   Perform LASSO regression. Normalize features using the min-max method, and select Lambda through repeated k-fold cross validation.   
%
%   INPUT:
%   
%           X     =     [Observations X Features] Predictor variables
%           Y     =     Outcome variable
%           k     =     k-fold cross-validation
%           rep   =     Number of cross-validation repetitions (5 recommended; 0 required)
%
%   OUTPUT
%
%           beta  =     Beta coefficients for LASSO model
%           R2    =     Coefficient of determination
%
%% Normalize Features (Min Max method)

normX = zeros(size(X));

for n = 1:size(X,2)
    min_val = min(X(:,n));
    max_val = max(X(:,n));
    normX(:,n) = (X(:,n) - min_val)/(max_val - min_val);
end

%% Run LASSO

LambdaMSE = zeros(rep,100);

for r = 1:rep
[B,FitInfo] = lasso(normX,Y,'CV',k);
LambdaMSE(r,:) = FitInfo.MSE;
end

[~,ind] = min(mean(LambdaMSE));
beta = B(:,ind);

predictedY = normX*beta + FitInfo.Intercept(FitInfo.IndexMinMSE);

%% Plot Real Data against Predicted Data  

scatter(Y,predictedY,'MarkerEdgeColor','k')
h = lsline;
set(h(1),'color','k')
ylabel('Predicted Data')
xlabel('Real Data')

%% Plot MSE as a function of Lambda

lassoPlot(B,FitInfo,'PlotType','CV');
legend('show')

R2 = rSquared(Y,predictedY);
fprintf('R2 = %1.3f\n',R2);
end
