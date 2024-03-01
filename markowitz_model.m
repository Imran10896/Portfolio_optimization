function w = markowitz_model(T)
%MARKOWITZ_MODEL Computes the maximum Sharpe ratio portfolio weights
%   w = MARKOWITZ_MODEL(T) computes the maximum Sharpe ratio portfolio
%   weights using the input table T, where each column represents an asset.
%   The function returns the optimal portfolio weights w.

%   Reference:

%   Cornuejols G, Tütüncü R. Optimization methods in finance. 
%   Cambridge University Press; 2006 Dec 21.

    % Create a portfolio object
    symbols = T.Properties.VariableNames;
    p = Portfolio('AssetList', symbols, 'RiskFreeRate', 0/252);
    
    % Estimate asset moments and set default constraints
    p = estimateAssetMoments(p, T);
    p = setDefaultConstraints(p);
  
    % Estimate maximum Sharpe ratio weights
    w = estimateMaxSharpeRatio(p);
end
