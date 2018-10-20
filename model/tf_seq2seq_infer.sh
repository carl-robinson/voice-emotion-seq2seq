# use text sequences provided as param, else use existing value of env variable
if [ $# = 1 ] #if number of params is 1 
then
	export DEV_SOURCES=$1
fi

# also specify model directory
if [ $# = 2 ] #if number of params is 2
then
	export DEV_SOURCES=$1
	export MODEL_DIR=$2
fi

export PRED_DIR=${MODEL_DIR}/pred
mkdir -p ${PRED_DIR}

python -m bin.infer \
  --tasks "
    - class: DecodeText" \
  --model_dir $MODEL_DIR \
  --input_pipeline "
    class: ParallelTextInputPipeline
    params:
      source_files:
        - $DEV_SOURCES" \
  >  ${PRED_DIR}/predictions.txt