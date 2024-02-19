function R = weightedcorrs(Y)
% Calculates the Pearson Weighted Correlation coefficients matrix.
%
%   R = weightedcorrs(Y, w, theta)
%
%   This function computes the weighted correlation coefficients matrix based on the input data matrix Y
%   and the vector of weights w.
%
%   Input Arguments:
%   - Y: Data matrix with dimensions (dt, N), where dt is the number of observations in the window and
%        N is the number of variables.
%   - w: Vector of weights with dimensions (1, N).
%   - theta: Parameter for exponential weights.
%
%   Output Argument:
%   - R: Weighted correlation coefficients matrix with dimensions (N, N).
%
%   Algorithm Details:
%   1. Remove the weighted mean from the data matrix Y.
%   2. Compute the weighted covariance matrix.
%   3. Ensure the matrix is exactly symmetric.
%   4. Calculate the variances and diagonalize them to obtain the standard deviations.
%   5. Compute the matrix of weighted correlation coefficients.
%
%   Note:
%   - The input data matrix Y should be properly formatted for the function to operate correctly.
%   - The vector of weights w should have the same number of elements as the number of variables in Y.
%
%   Example:
%   R = weightedcorrs(Y, theta);

% Get the dimensions of the data matrix Y
[dt, N] = size(Y);

function w_exp = expweights(dt, theta)
    % Calculate constant w0
    w0 = (1 - exp(-1/theta)) / (1 - exp(-dt/theta));
    
    % Calculate exponential weights for Pearson correlation
    w_exp(:,1) = w0 * exp(((1:dt) - dt) / theta);
    
    % Ensure sum of weights is 1
    w_exp = w_exp / sum(w_exp);
end

% Call the expweights function
w = expweights(dt, theta); 

% Remove the weighted mean
temp = Y - repmat(w' * Y, dt, 1);

% Compute the weighted covariance matrix
temp = temp' * (temp .* repmat(w, 1, N));

% Ensure the matrix is symmetric
temp = 0.5 * (temp + temp');

% Calculate the variances
R = diag(temp);

% Compute the matrix of weighted correlation coefficients
R = temp ./ sqrt(R * R');
end
