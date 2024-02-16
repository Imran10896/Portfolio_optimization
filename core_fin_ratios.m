% CORE_FIN_RATIOS - Calculates financial ratios for portfolio construction through core stocks.
%
%   [port_mean, port_std, port_shrp, B] = core_fin_ratios(Method, Portfolio_Size, num_windows, Data)
%
%   This function calculates financial ratios such as mean, standard deviation, and Sharpe ratio 
%   for portfolio construction through core stocks based on the given data.
%
%   Input Arguments:
%   - Method: Matrix indicating the method used for each asset in each window. 
%             The order of the matrix is total_stocks x num_windows.
%   - Portfolio_Size: Number of assets in the portfolio.
%   - num_windows: Number of windows.
%   - Data: Matrix containing data for all assets.
%
%   Output Arguments:
%   - port_mean: Mean of cumulative returns.
%   - port_std: Standard deviation of cumulative returns.
%   - port_shrp: Sharpe ratio of cumulative returns.
%   - B: Portfolio returns.
%
%   Note:
%   The function iterates over each window, extracts data for core stocks, 
%   performs portfolio optimization, and calculates financial ratios based on cumulative returns.
%
%   Example:
%   [port_mean, port_std, port_shrp, B] = core_fin_ratios(Method, Portfolio_Size, num_windows, Data);

function [port_mean, port_std, port_shrp, B] = core_fin_ratios(Method, Portfolio_Size, num_windows, Data)
    % Get the total number of stocks
    total_stocks = size(Method, 1);
    B = [];

    % Iterate over each window
    for i = 1:num_windows
        try
            T = [];
            % Extract data for core stocks in each window
            for j = (total_stocks - Portfolio_Size + 1):total_stocks
                a1 = Data(i : (124 + i), Method(j, i)); % one-day spiliting window
                T = [T, a1];
            end

            % Perform portfolio optimization
            symbol = T.Properties.VariableNames();
            p = Portfolio('AssetList', symbol, 'RiskFreeRate', 0/252);
            p = estimateAssetMoments(p, T);
            p = setDefaultConstraints(p);
            w = estimateMaxSharpeRatio(p);  

            % Extract data for the next time window
            T2 = [];
            for j = (total_stocks - Portfolio_Size + 1):total_stocks
                b1 = Data((i + 125) : (249 + i), Method(j, i)); 
                T2 = [T2, b1];
            end

            T2 = table2array(T2);
            a = T2 * w; % Portfolio returns
            B = [B, a]; 
        catch
            continue; % If an error occurs, continue to the next iteration
        end
    end

    % Calculate financial ratios based on cumulative returns
    portfolio_cum = cumsum(B, 1);
    port_mean = mean(portfolio_cum, 2);
    port_std = std(portfolio_cum, 0, 2);
    port_shrp = port_mean ./ port_std;
end
