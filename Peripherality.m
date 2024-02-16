%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function XpY = Peripherality(G)
PMFG_Top =(G ~= 0) * 1; % Topological planar(unweighted graph)
PMFG_GeoW = G; % Geodesic planar - weights(weighted graph)
PMFG_GeoW(PMFG_GeoW ~= 0) = 1 + ...
PMFG_GeoW(PMFG_GeoW ~= 0); % weights in [0, 2](weight shift in [0,2]
PMFG_GeoD = G; % Geodesic planar - distances(distances defined as a weight)
PMFG_GeoD(PMFG_GeoD ~= 0) = sqrt(2 * (1 - ...
PMFG_GeoD(PMFG_GeoD ~= 0))); % distances in [0, 2]
ShPTop = all_shortest_paths(PMFG_Top); % Top. Sh. Paths
ShPGeo = all_shortest_paths(PMFG_GeoD); % Geom. Sh. Paths(Error)
% 1. Topological Degree
DgrTopPMFG = full(sum(PMFG_Top));
% 2. Geometrical Degree: sum of weights (possibly negative)
DgrGeoPMFG = full(sum(PMFG_GeoW));
% 3. Betweenness (based on Topological Shortest Paths)
BtwTopPMFG = betweenness_centrality(PMFG_Top);
% 4. Betweenness (based on Geometrical Shortest Paths)(Error)
BtwGeoPMFG = betweenness_centrality(PMFG_GeoD);
% 5. Eccentricity (based on Topological Shortest Paths)
ExxTopPMFG = max(ShPTop); % eccentricity of vertexes
% 6. Eccentricity (based on Geometrical Shortest Paths)
ExxGeoPMFG = max(ShPGeo); % eccentricity of vertexes
% 7. Closeness (based on Topological Shortest Paths)
ClsTopPMFG = mean(ShPTop);
% 8. Closeness (based on Geometrical Shortest Paths)
ClsGeoPMFG = mean(ShPGeo);
% 9. Topological Eigenvector Centrality
[eigvec, eigval] = eigs(PMFG_Top); eigval = sum(eigval);
index = find(eigval == max(max(eigval)));
if all(round(eigvec(:, index) * 1e8) <= 0);
EigTopPMFG = -eigvec(:, index);
else
EigTopPMFG = eigvec(:, index);
end;
% 10. Geometrical Eigenvector Centrality
[eigvec, eigval] = eigs(PMFG_GeoW); eigval = sum(eigval);
index = find(eigval == max(max(eigval)));
if all(round(eigvec(:, index) * 1e8) <= 0);
EigGeoPMFG = -eigvec(:, index);
else
EigGeoPMFG = eigvec(:, index);
end;
% Calculate rankings
DgrGeoPMFG_rnks = tiedrank(-DgrGeoPMFG).';
DgrTopPMFG_rnks = tiedrank(-DgrTopPMFG).';
BtwTopPMFG_rnks = tiedrank(-BtwTopPMFG);
BtwGeoPMFG_rnks = tiedrank(-BtwGeoPMFG);
ExxGeoPMFG_rnks = tiedrank(ExxGeoPMFG).';
ExxTopPMFG_rnks = tiedrank(ExxTopPMFG).';
ClsGeoPMFG_rnks = tiedrank(ClsGeoPMFG).';
ClsTopPMFG_rnks = tiedrank(ClsTopPMFG).';
EigGeoPMFG_rnks = tiedrank(-EigGeoPMFG);
EigTopPMFG_rnks = tiedrank(-EigTopPMFG);
% Calculate indices
n = size(G, 1);
X =(DgrGeoPMFG_rnks + DgrTopPMFG_rnks + ...
BtwGeoPMFG_rnks + BtwTopPMFG_rnks - 4) / 4 / (n - 1);
Y = (ExxGeoPMFG_rnks + ExxTopPMFG_rnks + ...
ClsGeoPMFG_rnks + ClsTopPMFG_rnks + ...
EigGeoPMFG_rnks + EigTopPMFG_rnks -6) / 6 / (n - 1);
XpY = X + Y; XmY = X - Y;