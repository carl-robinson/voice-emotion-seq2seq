# voice-emotion-seq2seq
Voice emotion conversion model for DS/ML master's thesis. F0 contour mapping in sequence-to-sequence RNN-LSTM architecture in Tensorflow.

## Resources in this repo
__audio/__ - samples of original and transformed voice samples in WAV format
__data/__ - Matlab MAT files produced by AudioSculpt, containing F0 contours and syllable/phoneme alignments
__documentation/__ - PDF reports on the state of the art, aims, method, experimental setup, results and discussion
__model/__ - python code to build your own seq2seq model
__postprocessing/__ - code to process the outputted F0 contours and apply to neutral WAV files
__preprocessing/__ - code to process the MAT files to create input data for the model
__utilities/__ -  code to rename WAV files for use in the online survey, and to process survey results
__visualisation/__ -  jupyter notebooks to visualise the F0 contours

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Libraries:
Python 3.6, SciPy, Matplotlib (Anaconda recommended)
Tensorflow 1.4 or later (1.8 recommended)
[as_pysrc](http://forge.ircam.fr/p/as_pysrc/) - collection of modules for signal processing, maintained by the AS team on forge.ircam.fr (SSH access needed)

Software:
[AudioSculpt + IrcamAlign](http://anasynth.ircam.fr/home/english/software/audiosculpt) to generate .MAT files with F0 values and syllable/phoneme alignments

### Pre-processing & Model Training Process
* __tf_seq2seq_data_processing_phoneme_to_phoneme.ipynb__
    * check phrase/emotions/intensities are set correctly
    * check ratio of train/dev/test are correct (usually 0.8/0.2/0.0)
    * run all blocks to generate the syllable csv files, the combo source/target files and the vocab files
* __tf_seq2seq_data_processing_test_input.ipynb__
    * run first section to generate the test input (all 80 neutral source files)
    * put test_source.txt in the ..out/test directory (delete existing contents)
* __upload files to server__
    * scp -r /Users/robinson/Dropbox/anasynth/_data/emoVC/Olivia2006/f0_raw_phoneme/out/* robinson@gusli:/data2/anasynth_nonbp/robinson/tf_seq2seq_data3
* __tf_seq2seq_config.yml__
    * adjust params to fit length of source/target files (attention, max_seq_length, num_units)
* __kick off training and inference__
    * login to gusli
    * cd ~/code/tf_seq2seq
    * activate gpu environment
    * nohup bash ./tf_seq2seq_run.sh > nohup_$(date +"%Y%m%d_%H%M%S").out &

### Post-processing Process
* __download model directory (all checkpoints and predictions)__
    * scp -r robinson@gusli:/data2/anasynth_nonbp/robinson/tf_seq2seq_data/model/20180902_090436 ./20180902_090436
        * change date for latest model directory
* __download log__
    * scp robinson@gusli:/u/anasynth/robinson/code/tf_seq2seq/nohup_20180827_171528.out .
* __move the download__
    * make directory /Users/robinson/Downloads/data/pred/20180712_134318/ (change date)
    * make model subdirectory, and move the downloaded model folder into it, so it looks like /Users/robinson/Downloads/data/pred/20180713_153850/model/20180713_153850
* __get predictions.txt and process it__
    * get from /pred/
    * remove first line of txt file (comp device)
    * remove prefixes if using conditioned model (search and replace a/b/c for nothing)
    * put predictions.txt in directory where model is saved to e.g. /Users/robinson/Downloads/data/pred/20180712_134318/
* __tf_seq2seq_data_processing_make_new_contours.ipynb__
    * edit datetimestamp in directory path to match where you put predictions.txt
    * run to generate new phoneme files from predictions.txt for conversion operations to follow
* __tf_seq2seq_f0_transform_phoneme_nosyll.ipynb__
    * copy subdirectories of '/Users/robinson/Downloads/data/Olivia2006/Olivia2006_AUDIO’ to previous saved model directory e.g. /Users/robinson/Downloads/data/pred/20180712_134318/
    * set params at the top
        * edit directory path datestamp folder name at the top
        * change emotion to JOY, COL or other emotion tag
        * set interp = True
        * set harmonicity threshold, harm_thresh = 0.7
    * run all blocks
    * listen to the audio in the compare directory, and select the best ones
* __tf_seq2seq_data_comparison_phrase_phoneme_nosyll.ipynb__
    * run this to generate F0 contour figures in f0compare directory, for visual inspection of results
    * edit syll_input_directory_path datestamp folder name e.g. '/Users/robinson/Downloads/data/pred/20180712_134318/syllables’

## Authors

* **Carl Robinson** - *Master's Student* - [Voice Tech Podcast](https://voicetechpodcast.com)
* **Nicolas Obin** - *Supervisor* - [IRCAM - CNRS - Sorbonne Université](http://anasynth.ircam.fr/home/people/nicolasobin)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

This project would not have been possible without the generous help and support of many talented people. I would like to thank the following people for giving me their time, for sharing their knowledge and ideas, and for their continued encouragement:
* Nicolas Obin
* Axel Roebel, Guillaume Doras and Rafael Ferro
* Sylvie Thiria, Cecile Mallet, Sonia Garcia, Nesma Houmani, and Jerome Boudy
* Eric Bolo and the Batvoice team
* Veronique Sieng
