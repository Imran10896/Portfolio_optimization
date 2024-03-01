# Financial Analysis and Network Analysis Toolkit

This repository contains MATLAB and Python scripts for financial analysis, portfolio optimization, and network analysis. These scripts are designed to assist in analyzing financial data, constructing portfolios, calculating financial ratios, and detecting core-periphery structure in network.

## Contents

1. [Introduction](#introduction)
2. [Installation](#installation)
3. [Usage](#usage)
4. [Functions](#functions)
5. [References](#references)

## Introduction

The Financial Analysis and Network Analysis Toolkit provides a comprehensive set of scripts for analyzing financial data and network structures. Whether you're interested in portfolio management, financial ratio calculation, or network's core-periphery structure, this toolkit has you covered.

## Installation

To use the Financial Analysis and Network Analysis Toolkit, follow these steps:

1. Clone or download this repository to your local machine.
2. Ensure that you have MATLAB and Python installed on your system.
3. Navigate to the directory where you have cloned or downloaded this repository.

## Usage

You can use both MATLAB and Python scripts included in this toolkit. Follow the instructions provided in each script's README file for usage instructions.

## Functions

### MATLAB Functions


1. `hybrid_measure`: It calculates the peripherality of nodes in a network i.e.; The hybrid measure has a smaller value for the central vertices and a larger value for its peripheral vertices[1].
2. `weightedcorrs`: Calculates the Pearson Weighted Correlation coefficients matrix[5].
3. `markowitz_model`:It Computes the maximum Sharpe ratio portfolio weights[4].
4. `financial_ratios`: It calculates financial ratios such as mean, standard deviation, and Sharpe ratio based on portfolio returns.
5. `financial_ratios_uniform`: It calculates financial ratios based on uniformly weighted portfolio returns.
6. `market_uniform`: It calculates financial ratios for "market portfolio" with uniformly weighted portfolio returns.
7. `market_markowitz`:It calculates financial ratios for "market portfolio" using Markowitz portfolio optimization which maximize the Sharpe ratio.
8. `core_fin_ratios`: It calculates financial ratios for portfolio construction through core stocks.
9. `sort_out_mat` : The function iterates over each window, calculating the indices of the sorted matrix. 
   For zero scores, the indices are sorted in descending order of Sharpe ratios, while non-zero scores are sorted normally. 
   This structured representation of the sorted data facilitates further analysis and interpretation.



### Python Scripts

1. `Rossa_model.py`: It computes coreness of nodes in a network using Rossa et al model[3].
2. `Rombach_model.py`: It computes coreness of nodes in a network using Rombach et al model[2].
3. `cp_centralization.py`: It computes centralization of a network using the core-periphery model[3].


## References

1. Pozzi, F., Di Matteo, T., & Aste, T. (2013). Spread of risk across financial markets: better to invest in the peripheries. Scientific Reports, 3(1665), 1-6.
2. Rombach, P., Porter, M. A., Fowler, J. H., & Mucha, P. J. (2017). Core-Periphery Structure in Networks (Revisited). SIAM Review, 59(3), 619–646.
3. Rossa, F., Dercole, F., & Piccardi, C. (2013). Profiling core-periphery network structure by random walkers. Scientific Reports, 3(1467).
4. Cornuejols G, Tütüncü R. Optimization methods in finance. Cambridge University Press; 2006 Dec 21.
5. Pozzi F, Di Matteo T, Aste T. Exponential smoothing weighted correlations. The European Physical Journal B. 2012 Jun;85:1-21.
