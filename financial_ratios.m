function [port_mean, port_std, port_shrp, B] = financial_ratios(Method, Portfolio_Size, num_windows, Data_2014)
%FINANCIAL_RATIOS Calculates financial ratios based on portfolio returns.
%
%   [port_mean, port_std, port_shrp, B] = financial_ratios(Method, Portfolio_Size, num_windows, Data_2014)
%
%   This function calculates financial ratios such as mean, standard deviation, and Sharpe ratio 
%   based on portfolio returns obtained from the given data.
%
%   Input Arguments:
%   - Method: Matrix indicating the method used for each asset in each window.
%   - Portfolio_Size: Number of assets in the portfolio.
%   - num_windows: Number of windows.
%   - Data_2014: Matrix containing data for all assets.
%
%   Output Arguments:
%   - port_mean: Mean of cumulative returns.
%   - port_std: Standard deviation of cumulative returns.
%   - port_shrp: Sharpe ratio of cumulative returns.
%   - B: Portfolio returns.
%
%   Note:
%   The function iterates over each window, creates portfolios, estimates asset moments,
%   and calculates maximum Sharpe ratio weights. It then calculates financial ratios 
%   based on cumulative returns.
%
%   Reference:
%   [Provide any relevant references if applicable]
%
%   Example:
%   [port_mean, port_std, port_shrp, B] = financial_ratios(Method, Portfolio_Size, num_windows, Data_2014);

    B = [];

    % Loop through each window
    for i =  1:num_windows 
        try
            T = [];
            % Extract data for each asset in the portfolio
            for j = 1:Portfolio_Size
                a1 = Data_2014(i : (124 + i), Method(j, i)); % one-day splitting window
                T = [T, a1];
            end
    
            % Create a portfolio object
            symbol = T.Properties.VariableNames();
            p = Portfolio('AssetList', symbol, 'RiskFreeRate', 0/252);
            
            % Estimate asset moments and set default constraints
            p = estimateAssetMoments(p, T);
            p = setDefaultConstraints(p);
            
            % Estimate maximum Sharpe ratio weights
            w = estimateMaxSharpeRatio(p);
            
            T2 = [];

            % Extract data for each asset in the portfolio for the next time window
            for j = 1:Portfolio_Size
                b1 = Data_2014((i+125) : (249 + i), Method(j, i)); % one-day splitting window
                T2 = [T2, b1];
            end
            
            T2 = table2array(T2); % 240x5
            a = T2 * w; % 240x1
            B = [B, a]; 
            
        catch
            % If an error occurs, continue to the next iteration
            continue;
        end
    end

    % Calculate financial ratios based on cumulative returns
    portfolio_cum = cumsum(B, 1);
    port_mean = mean(portfolio_cum, 2);
    port_std = std(portfolio_cum, 0, 2);
    port_shrp = port_mean ./ port_std;

end
