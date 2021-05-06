%%
addpath D:\AXCPT\MATLAB\Scripts
addpath D:\AXCPT\Raw_data\Other
load('corr_measures')
load('corr_measures_names')
%%

y = CAARS_HypImp;
features = X;
k = 10;    
rep = 5;

%% Normalize Features (Min Max method)

normalized_features = zeros(size(X));

for n = 1:size(features,2)
    min_val = min(features(:,n));
    max_val = max(features(:,n));
    normalized_features(:,n) = (features(:,n) - min_val)/(max_val - min_val);
end

%% Run LASSO

LambdaMSE = zeros(rep,100);

for r = 1:rep
[B,FitInfo] = lasso(normalized_features,y,'CV',k);
LambdaMSE(r,:) = FitInfo.MSE;
end

[~,ind] = min(mean(LambdaMSE));
beta_coefficients = B(:,ind);

%% Plot Predicted Data and MSE for Values of Lambda

predicted_y = normalized_features*beta_coefficients + FitInfo.Intercept(FitInfo.IndexMinMSE);
scatter(y,predicted_y,'MarkerEdgeColor','k')
h = lsline;
set(h(1),'color','k')
ylabel('Predicted Data')
xlabel('Real Data')

lassoPlot(B,FitInfo,'PlotType','CV');
legend('show')

r2 = rSquared(y,predicted_y);
fprintf('R2 = %1.3f\n',r2);

