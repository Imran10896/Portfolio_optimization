function [Market_mean, Market_std, Market_shrp, B] = market_uniform(num_windows, Data)
% MARKET_UNIFORM - Calculates financial ratios for investing in the entire market.
%
%   [Market_mean, Market_std, Market_shrp, B] = market_uniform(num_windows, Data)
%
%   This function calculates financial ratios such as mean, standard deviation, and Sharpe ratio 
%   for investing in the entire market, i.e., all stocks.
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
%   The function iterates over each window, calculates the mean of cumulative returns 
%   for investing in the entire market, and then calculates financial ratios based on 
%   cumulative returns.
%
%   Example:
%   [Market_mean, Market_std, Market_shrp, B] = market_uniform(num_windows, Data);

B = [];   

    % Iterate over each window
    for i = 1:num_windows
        % Extract data for the current window (all stocks)
        b1 = Data((i+125) : (249 + i), :);     % one-day splitting window
        % Calculate mean of cumulative returns for the entire market
        a = mean(b1, 2); 
        B = [B a];
    end

    % Calculate cumulative returns
    portfolio_cum = cumsum(B, 1);  
    % Calculate financial ratios
    Market_mean = mean(portfolio_cum, 2);  
    Market_std = std(portfolio_cum, 0, 2);
    Market_shrp = Market_mean ./ Market_std;
end
