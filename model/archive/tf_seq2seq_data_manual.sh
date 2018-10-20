# Create Vocabulary
/Users/robinson/Dropbox/anasynth/_code/seq2seq/bin/tools/generate_vocab.py \
  < /Users/robinson/Dropbox/anasynth/_data/emoVC/Olivia2006/f0_raw/out/train/source_vocab_input.txt \
  > /Users/robinson/Dropbox/anasynth/_data/emoVC/Olivia2006/f0_raw/out/train/vocab.train_source.txt
echo "Wrote vocab.train_source.txt"

/Users/robinson/Dropbox/anasynth/_code/seq2seq/bin/tools/generate_vocab.py \
  < /Users/robinson/Dropbox/anasynth/_data/emoVC/Olivia2006/f0_raw/out/train/target_vocab_input.txt \
  > /Users/robinson/Dropbox/anasynth/_data/emoVC/Olivia2006/f0_raw/out/train/vocab.train_target.txt
echo "Wrote vocab.train_target.txt"

rm /Users/robinson/Dropbox/anasynth/_data/emoVC/Olivia2006/f0_raw/out/train/source_vocab_input.txt
rm /Users/robinson/Dropbox/anasynth/_data/emoVC/Olivia2006/f0_raw/out/train/target_vocab_input.txt