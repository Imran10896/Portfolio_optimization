# Import necessary libraries
import cpnet

def coreness_Rombach(G):
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
