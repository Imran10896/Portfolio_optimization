
Portfolio_Size=40;

Data= readtable('/home/imran/Documents/Data/Data_2014_21.csv');

path = "/home/imran/Documents/new_daily_data_CP_Final/Out_mat/corr_rombach_1846_2014_21_sharpe_filter.csv"

Method=readmatrix(path);

%num_windows = 685;    %0
%num_windows = 1369;   %50
%num_windows = 2737;   %75

%num_windows = 690;   % 815, 17_21

num_windows = 1721;   %1846,  14_21

%num_windows = 2959;   % nifty 200

%num_windows = 2955;   %nifty 500

[~, ~,~, B] = financial_ratios(Method, Portfolio_Size, num_windows, Data);

writematrix(B,"B_rombach_markowitz_p5_2014_21.csv")