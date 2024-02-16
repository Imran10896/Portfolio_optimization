function [port_mean, port_std, port_shrp, B] = financial_ratios_uniform(Method, Portfolio_Size, num_windows, Data)

%   This function calculates financial ratios such as mean, standard deviation, and Sharpe ratio 
%   based on portfolio returns obtained from uniformly weighted portfolios.
%
%   Input Arguments:
%   - Input Arguments:
%   - Method: Matrix indicating the method used for each asset in each window. The order of the matrix is total_stocks x total_windows,
%     where each column represents a window starting from the most peripheral stocks.
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
%   The function iterates over each window, extracts data for each asset, calculates 
%   the mean of cumulative returns for each portfolio with uniformly weighted assets, 
%   and then calculates financial ratios based on cumulative returns.
%
%   Example:
%   [port_mean, port_std, port_shrp, B] = financial_ratios_uniform(Method, Portfolio_Size, num_windows, Data);
    B = [];
    for i = 2:num_windows     
        portfolio = [];      
        for j = 1:Portfolio_Size
             b1 = Data_2014((i+125) : (249 + i), Method(j, i)); % one-day spiliting window
             portfolio = [portfolio b1];
        end
        portfolio_cum_mean = mean(portfolio, 2);
        B = [B portfolio_cum_mean];
    end
    portfolio_cum = cumsum(B, 1);
    port_mean = mean(portfolio_cum, 2);
    port_std = std(portfolio_cum, 0, 2);
    port_shrp = port_mean ./ port_std;
end
