#!/bin/sh
#PJM -L rscgrp=share-short
#PJM -L gpu=1
#PJM -g gn53
#PJM -X
#PJM -j
module load cuda/12.1
module load cudnn/8.8.1

source ~/heron_bench/bin/activate
cd ~/projects/heron/

export WANDB_PROJECT_NAME="heron-bench"

PLAYGROUND_PATH="./playground/data/japanese-heron-bench"
MODEL_CONFIG_PATH="./projects/video_blip/exp001.yml"
OUTPUT_PATH="${PLAYGROUND_PATH}/output"

EXP_NAME=$(basename "${MODEL_CONFIG_PATH}" .yml)

QUESTION_PATH="${PLAYGROUND_PATH}/questions_ja.jsonl"
CONTEXT_PATH="${PLAYGROUND_PATH}/context_ja.jsonl"
ANSWER_LIST_PATHS="${PLAYGROUND_PATH}/answers_gpt4.jsonl ${PLAYGROUND_PATH}/gpt4v_0404_ja.jsonl"
RULE_PATH="./playground/data/llava-bench-ja/rule.json"

OUTPUT_FILE="${OUTPUT_PATH}/${EXP_NAME}_reviews.json"

python heron/eval/eval_heron_bench.py \
    --question "${QUESTION_PATH}" \
    --context "${CONTEXT_PATH}" \
    --answer-list ${ANSWER_LIST_PATHS} \
    --rule "${RULE_PATH}" \
    --output "${OUTPUT_FILE}" \
    --is_upload_result
