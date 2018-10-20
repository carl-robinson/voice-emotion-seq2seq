export OUTPUT_DIR=/Users/robinson/Dropbox/anasynth/_code/tf_seq2seq_data
export OUTPUT_DIR_TRAIN="${OUTPUT_DIR}/train"

# Create Vocabulary
/Users/robinson/Dropbox/anasynth/_code/seq2seq/bin/tools/generate_vocab.py \
  < ${OUTPUT_DIR_TRAIN}/source_vocab_input.txt \
  > ${OUTPUT_DIR_TRAIN}/vocab.train_source.txt
echo "Wrote ${OUTPUT_DIR_TRAIN}/vocab.train_source.txt"

/Users/robinson/Dropbox/anasynth/_code/seq2seq/bin/tools/generate_vocab.py \
  < ${OUTPUT_DIR_TRAIN}/target_vocab_input.txt \
  > ${OUTPUT_DIR_TRAIN}/vocab.train_target.txt
echo "Wrote ${OUTPUT_DIR_TRAIN}/vocab.train_target.txt"

export VOCAB_SOURCE=${OUTPUT_DIR}/train/vocab.train_source.txt
export VOCAB_TARGET=${OUTPUT_DIR}/train/vocab.train_target.txt
export TRAIN_SOURCES=${OUTPUT_DIR}/train/train_source.txt
export TRAIN_TARGETS=${OUTPUT_DIR}/train/train_target.txt
export DEV_SOURCES=${OUTPUT_DIR}/dev/val_source.txt
export DEV_TARGETS=${OUTPUT_DIR}/dev/val_target.txt
export DEV_TARGETS_REF=${OUTPUT_DIR}/dev/val_target.txt
# export TRAIN_STEPS=1000