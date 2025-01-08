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

EVAL_MODEL_NAME="laioncc-w-1022k-to-gpt"

export WANDB_PROJECT_NAME="heron-bench"

PLAYGROUND_PATH="./playground/data/japanese-heron-bench"
OUTPUT_PATH="${PLAYGROUND_PATH}/output"

LLAVA_JP_HOME="~/projects/LLaVA-JP"
EVAL_ANSWER_PATH="${LLAVA_JP_HOME}/results/${EVAL_MODEL_NAME}/heron_bench.jsonl"

QUESTION_PATH="${PLAYGROUND_PATH}/questions_ja.jsonl"
CONTEXT_PATH="${PLAYGROUND_PATH}/context_ja.jsonl"
ANSWER_LIST_PATHS="${PLAYGROUND_PATH}/answers_gpt4.jsonl ${EVAL_ANSWER_PATH}"
RULE_PATH="./playground/data/llava-bench-ja/rule.json"

OUTPUT_FILE="${OUTPUT_PATH}/${EVAL_MODEL_NAME}_reviews.json"

python heron/eval/eval_heron_bench.py \
    --question "${QUESTION_PATH}" \
    --context "${CONTEXT_PATH}" \
    --answer-list ${ANSWER_LIST_PATHS} \
    --rule "${RULE_PATH}" \
    --output "${OUTPUT_FILE}" \
    --is_upload_result
