file=$1
while read line
do 
	mkdir $line
	mv $line*'_binary'* $line
done <$file
