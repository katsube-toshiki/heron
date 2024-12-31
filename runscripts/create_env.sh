#!/bin/sh
#PJM -L rscgrp=share-short
#PJM -L gpu=1
#PJM -g gn53
#PJM -X
#PJM -j
module load cuda/12.1
module load cudnn/8.8.1

cd ~
python -m venv heron_bench

source heron_bench/bin/activate
which python

cd projects/heron

pip install --upgrade pip  # enable PEP 660 support

pip install -r requirements.txt
pip install -e .

