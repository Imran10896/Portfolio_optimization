function w = expweights(dt, theta)
    % Calculate constant w0
    w0 = (1 - exp(-1/theta)) / (1 - exp(-dt/theta));
    
    % Calculate exponential weights for Pearson correlation
    w(:,1)=w0*exp(((1:dt)-dt)/theta);
    
    % Ensure sum of weights is 1
    w = w / sum(w);
end
