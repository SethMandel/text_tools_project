#!/c/Users/mande/AppData/Local/Microsoft/WindowsApps/python

import argparse
import sys

parser = argparse.ArgumentParser()

parser.add_argument('-s1', '--str1', required=True)
parser.add_argument('-s2', '--str2', required=True)
args = parser.parse_args()

def min_edit_distance(word1, word2):
    m, n = len(word1), len(word2)
    dp = [[0] * (n + 1) for _ in range (m + 1)]

    # Initialize the matrix
    [dp[i].__setitem__(0, i) for i in range(m + 1)]
    [dp[0].__setitem__(j, j) for j in range(n + 1)]

    # Populate the matrix
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            cost = 0 if word1[i - 1] == word2[j - 1] else 1

            # Calculate minimum edit distance
            dp[i][j] = min(
                dp[i - 1][j] + 1,    # Deletion
                dp[i][j - 1] + 1,    # Insertion
                dp[i - 1][j - 1] + cost     # Substitution
            )

    return dp[m][n]

med = min_edit_distance(args.str1, args.str2)
med_str = str(med)

sys.stdout.write(med_str)
