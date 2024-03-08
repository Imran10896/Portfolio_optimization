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

1. **pmfg.m**: Calculates the PMFG subgraph from a matrix of weights [1].
2. **weightedcorrs.m**: Calculates the Pearson Weighted Correlation coefficients matrix [2].
3. **hybrid_measure.m**: Calculates the peripherality of nodes in a network i.e., the hybrid measure has a smaller value for the central vertices and a larger value for its peripheral vertices [3].
4. **markowitz_model.m**: Computes the maximum Sharpe ratio portfolio weights [4].
5. **financial_ratios.m**: Calculates financial ratios such as mean, standard deviation, and Sharpe ratio based on portfolio returns.
6. **financial_ratios_uniform.m**: Calculates financial ratios based on uniformly weighted portfolio returns.
7. **market_uniform.m**: Calculates financial ratios for the "market portfolio" with uniformly weighted portfolio returns.
8. **market_markowitz.m**: Calculates financial ratios for the "market portfolio" using Markowitz portfolio optimization which maximizes the Sharpe ratio.
9. **core_fin_ratios.m**: Calculates financial ratios for portfolio construction through core stocks.
10. **sort_out_mat.m**: This function iterates over each window, calculating the indices of the sorted matrix. For zero scores, the indices are sorted in descending order of Sharpe ratios, while non-zero scores are sorted normally. This structured representation of the sorted data facilitates further analysis and interpretation.
11. **Rossa_model.py**: Computes the coreness of nodes in a network using the Rossa et al model [5].
12. **Rombach_model.py**: Computes the coreness of nodes in a network using the Rombach et al model [6].
13. **cp_centralization.py**: Computes the centralization of a network using the core-periphery model [5].

## References

1. Tumminello M, Aste T, Di Matteo T, Mantegna RN. A tool for filtering information in complex systems. Proceedings of the National Academy of Sciences. 2005 Aug 2;102(31):10421-6.
2. Pozzi F, Di Matteo T, Aste T. Exponential smoothing weighted correlations. The European Physical Journal B. 2012 Jun 1;85(6):1-21.
3. Pozzi F, Di Matteo T, Aste T. Spread of risk across financial markets: better to invest in the peripheries. Scientific reports. 2013 Dec 4;3(1):1665.
4. Cornuejols G, Tütüncü R. Optimization methods in finance. Cambridge University Press; 2006 Dec 21.
5. Rossa F, Dercole F, Piccardi C. Profiling core-periphery network structure by random walkers. Scientific reports. 2013 Feb 13;3(1):1467.
6. Rombach P, Porter MA, Fowler JH, Mucha PJ. Core-Periphery Structure in Networks (Revisited). SIAM Review. 2017 Sep 19;59(3):619-46.

