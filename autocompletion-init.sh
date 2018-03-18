# ./autocompletion-init.sh <python3> <force-redownload>
# make sure that all dependencies in autocompletion dir have been installed

py=$1
force=${2:-"1"}

mkdir -p autocompletion/data
if [ "$force" -eq "0" ]; then 
	if [ ! -f autocompletion/data/temp.model ]; then
		echo "model does not exist... downloading"
		wget -O autocompletion/data/temp.model "http://www-personal.umich.edu/~zijwang/temp.model"
	fi
else
	echo "model exists, but force to re-download"
	wget -O autocompletion/data/temp.model "http://www-personal.umich.edu/~zijwang/temp.model"
fi


ver=$($py -V 2>&1 | sed 's/.* \([0-9]\).\([0-9]\).*/\1\2/')
if [ "$ver" -gt "35" ]; then
	screen -dm $py autocompletion/run_model.py
else
	echo "python version is not greater than 3.5"
fi

