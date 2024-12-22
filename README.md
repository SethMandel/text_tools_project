# text_tools_project
## Topic

**English-Spanish Cognate Detection**

This project is a script to automatically detect cognates in a parallel corpus.

The source data is from the UN Parallel Corpus via huggingface

There are four bash scripts and one python script.

The results of the experiment are contained in the .tsv files attempt1, attempt2, and attempt3.

To replicate the work, follow these steps:
- Use head / tail commands to select about 10 lines for processing.
- Don't select too many lines. The runtime for proc_file.sh is about 30 min per 10 lines.
- Output data are not sorted, and duplicates are not remomved. To get files like "attempt1", "attempt2", etc. run
cat $file.out | sort -u > attempt#
