#!/bin/bash

# Writes config/UserToolsConfig.txt with the absolute path of each tool STRspy
# needs, taken from the environment that is active right now. Run it from the
# repository root, with the environment active.
#
# It stops if a tool is missing. Earlier versions wrote an empty value instead
# (XATLAS= when xatlas was not installed), and a run with an empty or wrong path
# does not fail: every call to that tool fails on its own line, the run still
# ends with #Done. and exit status 0, and the tables under Results/Countings/
# come out empty.

set -u

OUT=config/UserToolsConfig.txt

if [ ! -d config ]; then
	echo -e "\n#No config directory here. Run this from the repository root.\n" >&2
	exit 1
fi

missing=""
for tool in samtools bedtools xatlas parallel minimap2 seqkit; do
	command -v "$tool" >/dev/null 2>&1 || missing="$missing $tool"
done

if [ -n "$missing" ]; then
	echo -e "\n#Not on PATH:$missing" >&2
	echo -e "#Activate the environment (conda activate strspy_env) and try again." >&2
	echo -e "#Nothing was written to $OUT.\n" >&2
	exit 1
fi

SAMTOOLS=$(command -v samtools)
echo -e "SAMTOOLS="$SAMTOOLS > $OUT
BEDTOOLS=$(command -v bedtools)
echo -e "BEDTOOLS="$BEDTOOLS >> $OUT
XATLAS=$(command -v xatlas)
echo -e "XATLAS="$XATLAS >> $OUT
PARALLEL=$(command -v parallel)
echo -e "PARALLEL="$PARALLEL >> $OUT
MINIMAP=$(command -v minimap2)
echo -e "MINIMAP="$MINIMAP >> $OUT
SEQKIT=$(command -v seqkit)
echo -e "SEQKIT="$SEQKIT >> $OUT

echo -e "ToolConfig file is generated."
