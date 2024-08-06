DATADIR=$1
DATAOUT=$2
mkdir -p $DATAOUT

find -L $DATADIR -name "*_all_sep.wav" |\
grep -v "'" |\
xargs -I{} basename {} .wav |\
xargs -P120 -I{} ffmpeg -loglevel 0 -i $DATADIR/{}.wav -ar 44100 -ac 1 -f segment -segment_time 15 -acodec pcm_s16le $DATAOUT/{}_%03d.wav -y
find $DATAOUT -size -2k | xargs -I{} -P80 rm '{}'