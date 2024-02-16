# Import necessary libraries
import cpnet
import numpy as np
import pandas as pd

def cp_centralization(G):
    """
    Calculates the core-periphery centralization of a network using Rossa's algorithm.

    Parameters:
        G (networkx.Graph): Input graph.

    Returns:
        float: Core-periphery centralization value.

    Algorithm Details:
        The core-periphery centralization (C) measures the concentration of coreness values 
        within the network. It is calculated based on the coreness values obtained from 
        the Rossa algorithm. The formula used to compute C is as follows:

        C = 1 - (2 / (N - 2)) * (sum(x_core) - 1)

        Where:
        - N is the total number of nodes in the network.
        - x_core is an array containing the coreness values of nodes.

        Reference:
        F. Rossa, F. Dercole, and C. Piccardi. Profiling core-periphery network structure 
        by random walkers. Scientific Reports, 3, 1467, 2013.

    Notes:
        - Weighted: Yes
        - Directed: No
        - Multiple groups of core-periphery pairs: No
        - Continuous core-periphery structure: Yes
    """
    # Load the Rossa algorithm
    alg = cpnet.Rossa() 
    
    # Detect core-periphery structure in the network
    alg.detect(G) 
    
    # Get coreness values
    x = alg.get_coreness()  
    
    # Extract coreness values as array
    x_core = np.array(pd.DataFrame(list(x.items()))[1])
    
    # Calculate core-periphery centralization
    C = 1 - (2 / (G.number_of_nodes() - 2)) * (np.sum(x_core) - 1)
    
    return C  
