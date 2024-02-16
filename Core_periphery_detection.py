# Import necessary libraries
import cpnet
import networkx as nx
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from cpnet import CPAlgorithm
import numba
from simanneal import Annealer
from cpnet.utils import zipfile

# Path to the zip file
zip_file_path = "/home/imran/Documents/new_daily_data_CP_Final/Adj_mat/Nifty_500_adj_mat_exp_2010_22.zip"
# Name of the CSV file within the zip
csv_file_name = 'Nifty_500_adj_mat_exp_2010_22.csv'

# Extract the CSV file from the zip
with zipfile.ZipFile(zip_file_path, 'r') as zip_ref:
    zip_ref.extract(csv_file_name)

# Read the CSV file into a DataFrame
df = pd.read_csv(csv_file_name, header=None)

# Data transformation
data = df.applymap(lambda x: (1 + x) / 2 if x != 0 else 0)

# Define the number of windows and stocks
num_windows = 3080
num_stocks = len(data.iloc[0])

# Extract stock points for each window
Stock_points = []
for r in range(1, num_windows + 1):
    A = data.iloc[num_stocks * r - num_stocks:num_stocks * r, :]
    Stock_points.append(A)

# Perform CP algorithm for each window
Rombach_cor_per = []
for k in range(0, num_windows):
    corr = np.array(Stock_points[k])
    np.fill_diagonal(corr, 0)
    G = nx.from_numpy_array(corr)
    alg = cpnet.Rossa()
    alg.detect(G)
    x = alg.get_coreness()
    v = np.array(pd.DataFrame(list(x.items()))[1])
    Rombach_cor_per.append(v)

# Convert results to DataFrame and save as CSV
df = pd.DataFrame(Rombach_cor_per).T
df.to_csv('score_Nifty_500_exp_2010_22.csv', index=False, header=False)
