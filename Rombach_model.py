import cpnet

def Rombach_model(G, num_runs=10, alpha=0.5, beta=0.8, algorithm="ls"):
    """
    Calculates the coreness of nodes in a network using Rombach's algorithm.
    
    Parameters:
        G (networkx.Graph): Input graph.
        num_runs (int): Number of runs of the algorithm, defaults to 10.
        alpha (float): Size of the score jump between the highest-scoring 
                       peripheral node and the lowest-scoring core node, defaults to 0.5. 
        beta (float): The size of the core (as β varies from 0 to 1, the number The number of nodes
                       included in the core varies from N to 0)., defaults to 0.8.
        algorithm (str): Optimization algorithm. Choose between 'ls' (label switching) 
                           and 'sa' (simulated annealing). Defaults to 'ls'.
        
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
    # Class definition for Rombach algorithm parameters
    class RombachParameters:
        def __init__(self, num_runs=10, alpha=0.5, beta=0.8, algorithm="ls"):
            """Initialize Rombach algorithm parameters.

            Parameters:
                - num_runs (int): Number of runs of the algorithm, defaults to 10.
                - alpha (float): Size of the score jump between the highest-scoring 
                       peripheral node and the lowest-scoring core node, defaults to 0.5. 
                - beta (float): The size of the core (as β varies from 0 to 1, the number The number of nodes
                       included in the core varies from N to 0)., defaults to 0.8.
                - algorithm (str): Optimization algorithm, defaults to "ls".
            
            Note:
                In the original paper, the authors adopted a simulated annealing to optimize 
                the objective function, which is computationally demanding. To mitigate 
                the computational cost, a label switching algorithm is implemented in cpnet.
                One can choose either algorithm by specifying algorithm='ls' (i.e., label switching) 
                or algorithm='sa' (i.e., simulated annealing).
            """
            self.num_runs = num_runs
            self.alpha = alpha
            self.beta = beta
            self.algorithm = algorithm
    
    # Load the Rombach algorithm with specified parameters
    alg = cpnet.Rombach(num_runs=num_runs, alpha=alpha, beta=beta, algorithm=algorithm)
    
    # Feed the network as an input
    alg.detect(G)
    
    # Get coreness of nodes
    coreness = alg.get_coreness()
    
    return coreness
