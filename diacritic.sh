#!/bin/bash

# Very specific solution for a very specific problem
# When saved as .tsv instead of .csv, the source data lost some diacritics. Unclear why.
# This script is just to repair that encoding

sed -e 's/<E1>/á/g' -e 's/<E9>/é/g' -e 's/<ED>/í/g' -e 's/<F3>/ó/g' -e 's/<FA>/ú/g' -e 's/<F1>/ǹ/g' $1 > $1.out
