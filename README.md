# Financial Analysis and Network Analysis Toolkit

This repository contains MATLAB and Python scripts for financial analysis, portfolio optimization, and network analysis. These scripts are designed to assist in analyzing financial data, constructing portfolios, calculating financial ratios, and analyzing network centrality.

## Contents

1. [Introduction](#introduction)
2. [Installation](#installation)
3. [Usage](#usage)
4. [Functions](#functions)
5. [References](#references)

## Introduction

The Financial Analysis and Network Analysis Toolkit provides a comprehensive set of scripts for analyzing financial data and network structures. Whether you're interested in portfolio management, financial ratio calculation, or network centrality analysis, this toolkit has you covered.

## Installation

To use the Financial Analysis and Network Analysis Toolkit, follow these steps:

1. Clone or download this repository to your local machine.
2. Ensure that you have MATLAB and Python installed on your system.
3. Navigate to the directory where you have cloned or downloaded this repository.

## Usage

You can use both MATLAB and Python scripts included in this toolkit. Follow the instructions provided in each script's README file for usage instructions.

## Functions

### MATLAB Functions


1. `centrinds`: It calculates peripherality of a node in a network proposed by the Pozzi et al[1].
1. `financial_ratios`: It calculates financial ratios such as mean, standard deviation, and Sharpe ratio based on portfolio returns.
2. `financial_ratios_uniform`: It calculates financial ratios based on uniformly weighted portfolio returns.
3. `market_uniform`: It calculates financial ratios for investing in the whole market with uniformly weighted portfolio returns.
4. `market_markowitz`: It calculates financial ratios for investing in the whole market using Markowitz portfolio optimization.
5. `core_fin_ratios`: It calculates financial ratios for portfolio construction through core stocks.


### Python Scripts

1. `coreness_Rossa.py`: It computes coreness of a node in a network using Rossa model[3].
2. `coreness_Rombach.py`: It computes coreness of a node in a network using Rombach model[2].
3. `cp_centralization.py`: It computes centralization of a network using the core-periphery model[3].


## References

1. Pozzi, F., Di Matteo, T., & Aste, T. (2013). Spread of risk across financial markets: better to invest in the peripheries. Scientific Reports, 3(1665), 1-6.
2. Rombach, P., Porter, M. A., Fowler, J. H., & Mucha, P. J. (2017). Core-Periphery Structure in Networks (Revisited). SIAM Review, 59(3), 619–646.
3. Rossa, F., Dercole, F., & Piccardi, C. (2013). Profiling core-periphery network structure by random walkers. Scientific Reports, 3(1467).
