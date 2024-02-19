function sort_out_mat = sort_out_mat(path1 , path2)

%   Input Arguments:
%   - path1: Path to the CSV file containing the scores of each window in columns using the core-periphery model.
%   - path2: Path to the CSV file containing the dataset.
%
%   Output Argument:
%   - sort_out_mat: A matrix where each column corresponds to a window of data. In each column, the indices indicate the sorted order of scores.
%
%   Algorithm Details:
%   The function iterates over each window, calculating the indices of the sorted matrix. 
%   For zero scores, the indices are sorted in descending order of Sharpe ratios, while non-zero scores are sorted normally. 
%   This structured representation of the sorted data facilitates further analysis and interpretation.
%
%   Note:
%   - The CSV files should contain appropriate data for the function to operate correctly.
%
%   Example:
%   sort_out_mat = sort_out_mat('path_to_scores.csv', 'path_to_dataset.csv');

% Read the core-periphery model scores and dataset
score_matrix = readmatrix(path1);     
Data = readmatrix(path2);    

num_windows = size(score_matrix, 2);

sort_out_mat = [];

for i = 1:num_windows
    column = score_matrix(:, i);

    % Find indices of zero entries in the first column
    zero_indices = find(column == 0);

    % Initialize matrices to store Sharpe ratios and non-zero scores
    M_sharpe = [];
    M_non_zero = [];
    zero_indices_with_sharpe = zeros(1, length(zero_indices));

    % Calculate Sharpe ratio for zero scores
    for j = 1:length(zero_indices)
        f = Data(i:i+124, zero_indices(j)); % one_day splitting windows
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

    sort_out_mat = [sort_out_mat combined_sorted_indices];
end
end 
