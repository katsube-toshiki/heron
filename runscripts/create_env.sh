#!/bin/sh
#PJM -L rscgrp=share
#PJM -L gpu=1
#PJM -L elapse=00:30:00
#PJM -g gn53
#PJM -X
#PJM -j
module load cuda/12.1
module load cudnn/8.8.1

cd ~
rm -rf heron_bench
python -m venv heron_bench

source heron_bench/bin/activate
which python

cd projects/heron

pip install --upgrade pip  # enable PEP 660 support

pip install "numpy<2"
pip install -r requirements.txt
pip install -e .

