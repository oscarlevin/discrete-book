#!/usr/bin/env bash

# This file was automatically generated with PreTeXt 2.26.0.
# If you modify this file, PreTeXt will no longer automatically update it.

# Conda should already be installed in the codespace.  We need to add the conda-forge channel

conda config --add channels conda-forge
conda config --set channel_priority strict

# We don't want conda to open the base environment always:
conda config --set auto_activate_base false

# Now create a conda environment for sage (called sage):
conda create --yes -n sage sage python=3.12

conda init

echo 'conda activate sage' >> ~/.bashrc

source ~/.bashrc
