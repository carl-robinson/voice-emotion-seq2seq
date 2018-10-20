export LOG_DIR=/data2/anasynth_nonbp/robinson/tf_seq2seq_data/model

# accept datastemp folder name as param e.g. 20180413_124853
if [ $# = 1 ] #if number of params is 1
then
  export MODEL_DIR=$LOG_DIR/$1
else
  export MODEL_DIR=$LOG_DIR/$(date +"%Y%m%d_%H%M%S")
  mkdir -p $MODEL_DIR
fi

LC_ALL=C 2>/dev/null 1>/dev/null tensorboard --logdir $MODEL_DIR --port 3456 &

python -m bin.train \
  --config_paths="
      ./config/tf_seq2seq_config.yml,
      ./config/train_seq2seq.yml" \
  --model_params "
      vocab_source: $VOCAB_SOURCE
      vocab_target: $VOCAB_TARGET" \
  --input_pipeline_train "
    class: ParallelTextInputPipeline
    params:
      source_files:
        - $TRAIN_SOURCES
      target_files:
        - $TRAIN_TARGETS" \
  --input_pipeline_dev "
    class: ParallelTextInputPipeline
    params:
       source_files:
        - $DEV_SOURCES
       target_files:
        - $DEV_TARGETS" \
  --batch_size 256 \
  --train_steps 100000 \
  --save_checkpoints_steps 2000 \
  --keep_checkpoint_max None \
  --log_device_placement True \
  --gpu_allow_growth True \
  --output_dir $MODEL_DIR
