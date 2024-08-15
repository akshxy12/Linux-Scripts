fontname=$1
fontdirectory=~/.fonts

found=$(find $fontdirectory -type d -iname "$fontname*");
foldername=$(basename $found);

rm -r -f $found
echo "Removed $foldername";