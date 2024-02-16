# Import necessary libraries
import cpnet

def coreness_Rombach(G):
    """
    Calculates the coreness of nodes in a network using Rombach's algorithm.
    
    Parameters:
        G (networkx.Graph): Input graph.
        
    Returns:
        tuple: A tuple containing two elements:
            - dict: Dictionary mapping node IDs to pair IDs.
            - dict: Dictionary mapping node IDs to coreness values.
    """
    # Load the Rombach algorithm
    alg = cpnet.Rombach()
    
    # Feed the network as an input
    alg.detect(G)
    
    # Get pair IDs and coreness of nodes
    pair_id = alg.get_pair_id()
    coreness = alg.get_coreness()
    
    return pair_id, coreness
