% Read the entire CSV file
score_rossa = readmatrix('/home/imran/Documents/Score_matrix/Daily_return_score_matrix/score_corr_rombach_1846_2014_21.csv');
Data_2014 = readmatrix('/home/imran/Documents/Data/Data_2014_21.csv');
num_windows = size(score_rossa, 2);
mat = [];
for i = 1:num_windows
    column = score_rossa(:, i);
    % Find indices of zero entries in the first column
    zero_indices = find(column == 0);
    % Initialize matrices to store Sharpe ratios and non-zero scores
    M_sharpe = [];
    M_non_zero = [];
    zero_indices_with_sharpe = zeros(1, length(zero_indices));
    % Calculate Sharpe ratio for zero scores
    for j = 1:length(zero_indices)
        %f = Data_2014((-239) + 240 * i : (240 * i), zero_indices(j)); %Non-overlapping
        %f = Data_2014((-119)+120*i : (120*i + 120), zero_indices(j)); %50% overlap
        %f = Data_2014((-59) + 60 * i : (60 * i + 180), zero_indices(j)); %75% overlap
        f = Data_2014(i:i+124, zero_indices(j)); %one-day splitting windows
        sharpe_ratio = mean(f) / std(f);
        M_sharpe = [M_sharpe sharpe_ratio];
        zero_indices_with_sharpe(j) = zero_indices(j);
    end
    % Create a table with zero indices and Sharpe ratios
    result_table = table(zero_indices_with_sharpe', M_sharpe', 'VariableNames', {'Zero_Indices', 'Sharpe_Ratio'});
    % Sort the table based on Sharpe Ratio in descending order
    sorted_table = sortrows(result_table, 'Sharpe_Ratio', 'descend');
    % Extract the sorted indices for zero scores
    sorted_indices_zero = sorted_table.Zero_Indices;
    % Find indices of non-zero entries in the first column
    non_zero_indices = find(column ~= 0);
    % Sort the non-zero indices based on the original scores
    [~, sorted_indices_non_zero] = sort(column(non_zero_indices));
    % Combine the sorted indices for zero and non-zero scores
    combined_sorted_indices = [sorted_indices_zero; non_zero_indices(sorted_indices_non_zero)];
    mat = [mat combined_sorted_indices];
end
writematrix(mat, 'corr_rombach_1846_2014_21_sharpe_filter.csv');
