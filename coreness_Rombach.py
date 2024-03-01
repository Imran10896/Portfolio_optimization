import cpnet

def Rombach_model(G):
    """
    Calculates the coreness of nodes in a network using Rombach's algorithm.
    
    Parameters:
        G (networkx.Graph): Input graph.
        
    Returns:
        dict: Dictionary mapping node IDs to coreness values.
        
    Notes:
        - Weighted: Yes
        - Directed: No
        - Multiple groups of core-periphery pairs: No
        - Continuous core-periphery structure: Yes
        
    Algorithm Details:
        The coreness of nodes in the network is calculated based on Rombach's algorithm. 
        The algorithm aims to identify the core-periphery structure in networks 
        and provides continuous coreness values for each node.

    Reference:
        P. Rombach, M. A. Porter, J. H. Fowler, and P. J. Mucha. Core-Periphery Structure 
        in Networks (Revisited). SIAM Review, 59(3):619–646, 2017.

    Algorithm Parameters:
        - algorithm (str): Optimization algorithm. Choose between 'ls' (label switching) 
                           and 'sa' (simulated annealing). Defaults to 'ls'.

        In the original paper, the authors adopted simulated annealing to optimize 
        the objective function, which is computationally demanding. To mitigate 
        the computational cost, a label switching algorithm is implemented in cpnet. 
        One can choose either algorithm by specifying algorithm='ls' for label switching 
        or algorithm='sa' for simulated annealing.
    """
    # Load the Rombach algorithm
    alg = cpnet.Rombach()
    
    # Feed the network as an input
    alg.detect(G)
    
    # Get coreness of nodes
    coreness = alg.get_coreness()
    
    return coreness
