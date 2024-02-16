% MARKET_MARKOWITZ - Calculates financial ratios for investing in the entire market using Markowitz portfolio optimization.
%
%   [Market_mean, Market_std, Market_shrp, B] = market_markowitz(num_windows, Data)
%
%   This function calculates financial ratios such as mean, standard deviation, and Sharpe ratio 
%   for investing in the entire market using Markowitz portfolio optimization.
%
%   Input Arguments:
%   - num_windows: Number of windows.
%   - Data: Matrix containing data for all assets.
%
%   Output Arguments:
%   - Market_mean: Mean of cumulative returns.
%   - Market_std: Standard deviation of cumulative returns.
%   - Market_shrp: Sharpe ratio of cumulative returns.
%   - B: Portfolio returns.
%
%   Note:
%   The function iterates over each window, performs Markowitz portfolio optimization to determine the optimal weights 
%   for investing in the entire market, and then calculates financial ratios based on cumulative returns.
%
%   Example:
%   [Market_mean, Market_std, Market_shrp, B] = market_markowitz(num_windows, Data);

function [Market_mean, Market_std, Market_shrp, B] = market_markowitz(num_windows, Data)
    
    B = [];

    % Iterate over each window
    for i = 1:num_windows
        % Extract data for the current window
        T = Data(i : (124 + i), :);  % one-day splitting window
        symbol = T.Properties.VariableNames();
        % Perform Markowitz portfolio optimization
        p = Portfolio('AssetList', symbol, 'RiskFreeRate', 0/252);
        p = estimateAssetMoments(p, T);
        p = setDefaultConstraints(p);
        w = estimateMaxSharpeRatio(p);  

        % Extract data for the next time window
        T1 = Data((i + 125) : (249 + i), :); 
        T2 = table2array(T1);

        % Calculate portfolio returns
        a = T2 * w;          
        B = [B a];
    end

    % Calculate cumulative returns
    portfolio_cum = cumsum(B, 1);  
    % Calculate financial ratios
    Market_mean = mean(portfolio_cum, 2);  
    Market_std = std(portfolio_cum, 0, 2);
    Market_shrp = Market_mean ./ Market_std;
end
