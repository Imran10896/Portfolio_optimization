# Import necessary libraries
import cpnet

def coreness(G):
    """
    Calculates the coreness of nodes in a network using the Rossa algorithm.
    
    Parameters:
        G (networkx.Graph): Input graph.
        
    Returns:
        dict: Dictionary mapping node IDs to coreness values.
    """
    # Load the Rossa algorithm
    alg = cpnet.Rossa()
    
    # Feed the network as an input
    alg.detect(G)
    
    # Get the coreness of nodes
    x = alg.get_coreness()
    
    return x
