#!/bin/bash
# Copyright (c) Microsoft Corporation.
# SPDX-License-Identifier: Apache-2.0

# DeepSpeed Team

# Note that usually LoRA needs to use larger learning rate
OUTPUT_PATH=./output
mkdir -p $OUTPUT_PATH

deepspeed main.py \
   --data_split 2,4,4 \
   --model_name_or_path "/tmp/DeepSpeedExamples20230415/applications/DeepSpeed-Chat/model/opt-1.3b" \
   --per_device_train_batch_size 4 \
   --per_device_eval_batch_size 4 \
   --max_seq_len 512 \
   --learning_rate 1e-3 \
   --weight_decay 0.1 \
   --num_train_epochs 2 \
   --gradient_accumulation_steps 1 \
   --lr_scheduler_type cosine \
   --num_warmup_steps 0 \
   --seed 1234 \
   --zero_stage 0 \
   --lora_dim 128 \
   --lora_module_name decoder.layers. \
   --only_optimize_lora \
   --deepspeed \
   --output_dir $OUTPUT_PATH \
   &> $OUTPUT_PATH/training.log
