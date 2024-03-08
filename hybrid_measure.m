function P = hybrid_measure(G)
% HYBRID_MEASURE Calculates peripherality of a node in a network.
%
% Reference:
% Pozzi, F., Di Matteo, T., & Aste, T. (2013). Spread of risk across financial markets: 
% better to invest in the peripheries. Scientific Reports, 3(1665), 1-6.
%
% INPUT:
% G: Planar Maximally Filtered Graph stored as a symmetric N-by-N sparse matrix (correlation matrix).
%
% OUTPUT:
% P: Peripherality value. The value of P is small for the central vertices and large for its peripheral vertices in the network.
%
% Algorithm:
% This function calculates peripherality of a node in a network based on the method described in the reference paper.
%
% Steps:
% 1. Preprocess the graph.
% 2. Calculate shortest paths.
% 3. Compute the Degree (D), the Betweenness Centrality, the Eccentricity, the Closeness and the Eigenvector Centrality for both weighted and unweighted graphs
% 4. Calculate rankings.
% 5. Compute peripherality value P.
%
% Note:
% The value of P is small for the central vertices and large for its peripheral vertices in the network.
%   
    % Step 1: Preprocess the graph
    PMFG_Top = (G ~= 0) * 1; % Topological planar
    PMFG_GeoW = G; % Geodesic planar - weights
    PMFG_GeoW(PMFG_GeoW ~= 0) = 1 + PMFG_GeoW(PMFG_GeoW ~= 0); % weights in [0, 2]
    PMFG_GeoD = G; % Geodesic planar - distances
    PMFG_GeoD(PMFG_GeoD ~= 0) = sqrt(2 * (1 - PMFG_GeoD(PMFG_GeoD ~= 0))); % distances in [0, 2]
    
    % Step 2: Calculate shortest paths
    ShPTop = all_shortest_paths(PMFG_Top); % Topological Shortest Paths
    ShPGeo = all_shortest_paths(PMFG_GeoD); % Geometrical Shortest Paths
    
    % Step 3: Calculate graph properties
    DgrTopPMFG = full(sum(PMFG_Top)); % Topological Degree
    DgrGeoPMFG = full(sum(PMFG_GeoW)); % Geometrical Degree: sum of weights
    BtwTopPMFG = betweenness_centrality(PMFG_Top); % Betweenness (based on Topological Shortest Paths)
    BtwGeoPMFG = betweenness_centrality(PMFG_GeoD); % Betweenness (based on Geometrical Shortest Paths)
    ExxTopPMFG = max(ShPTop); % Eccentricity (based on Topological Shortest Paths)
    ExxGeoPMFG = max(ShPGeo); % Eccentricity (based on Geometrical Shortest Paths)
    ClsTopPMFG = mean(ShPTop); % Closeness (based on Topological Shortest Paths)
    ClsGeoPMFG = mean(ShPGeo); % Closeness (based on Geometrical Shortest Paths)
    
    [eigvec, eigval] = eigs(PMFG_Top);
    eigval = sum(eigval);
    index = find(eigval == max(max(eigval)));
    if all(round(eigvec(:, index) * 1e8) <= 0)
        EigTopPMFG = -eigvec(:, index);
    else
        EigTopPMFG = eigvec(:, index);
    end
    
    [eigvec, eigval] = eigs(PMFG_GeoW);
    eigval = sum(eigval);
    index = find(eigval == max(max(eigval)));
    if all(round(eigvec(:, index) * 1e8) <= 0)
        EigGeoPMFG = -eigvec(:, index);
    else
        EigGeoPMFG = eigvec(:, index);
    end
    
    % Step 4: Calculate rankings
    DgrGeoPMFG_rnks = tiedrank(-DgrGeoPMFG)';
    DgrTopPMFG_rnks = tiedrank(-DgrTopPMFG)';
    BtwTopPMFG_rnks = tiedrank(-BtwTopPMFG)';
    BtwGeoPMFG_rnks = tiedrank(-BtwGeoPMFG)';
    ExxGeoPMFG_rnks = tiedrank(ExxGeoPMFG)';
    ExxTopPMFG_rnks = tiedrank(ExxTopPMFG)';
    ClsGeoPMFG_rnks = tiedrank(ClsGeoPMFG)';
    ClsTopPMFG_rnks = tiedrank(ClsTopPMFG)';
    EigGeoPMFG_rnks = tiedrank(-EigGeoPMFG)';
    EigTopPMFG_rnks = tiedrank(-EigTopPMFG)';
    
    n = size(G, 1);
    X = (DgrGeoPMFG_rnks + DgrTopPMFG_rnks + BtwGeoPMFG_rnks + BtwTopPMFG_rnks - 4) / 4 / (n - 1);
    Y = (ExxGeoPMFG_rnks + ExxTopPMFG_rnks + ClsGeoPMFG_rnks + ClsTopPMFG_rnks + EigGeoPMFG_rnks + EigTopPMFG_rnks - 6) / 6 / (n - 1);
    P = X + Y;
    
end
