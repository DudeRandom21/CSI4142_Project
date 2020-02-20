for f in "$@"
do
	sed -i 's/\.0,/,/g' $f
done
