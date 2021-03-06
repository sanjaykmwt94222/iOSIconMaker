if [[ ! $1 ]]
then
	echo Please provide source image
	exit 0
elif [[ ! $2 ]]
then
	echo Please provide destination
	exit 0
fi

source=$1
folder=$2

mkdir -p $folder

resizeImg () {
	width=$1
	sips -z $width $width -s format png $folder"/temp.bmp" --out $folder"/icon_"$width"x"$width".png"
	sips -z $((width*2)) $((width*2)) -s format png $folder"/temp.bmp" --out $folder"/icon_"$width"x"$width"@2x.png"
	sips -z $((width*3)) $((width*3)) -s format png $folder"/temp.bmp" --out $folder"/icon_"$width"x"$width"@3x.png"
}

sizesVariants=(20 29 40 50 57 60 72 76)

sips -s format bmp $source --out $folder"/temp.bmp"
for item in ${sizesVariants[*]}
do
  resizeImg $item
done

sips -z 167 167   -s format png $folder"/temp.bmp" --out $folder"/icon_83.5x83.5@2x.png"
sips -z 1024 1024 -s format png $folder"/temp.bmp" --out $folder"/icon_1024x1024.png"

rm -rf $folder"/temp.bmp"
