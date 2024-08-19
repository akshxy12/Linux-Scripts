#!/bin/bash

fontname=$1;
currentdir=$(pwd);
fontzipfolder="$currentdir/$fontname";
fontdirectorylocation=~
fontdirectory=.fonts

# Searching for the zip folder
echo "Searching for $fontzipfolder...";

# Checking if fontname includes '.zip' or not
if [[ "$fontname" =~ \.zip$ ]];
then
    found=$(find $currentdir -iname $fontname);
else
    found=$(find $currentdir -iname "$fontname*.zip");
fi

echo "Found: $found";

if [ -z $found ] 
then
    echo "Could not find the zip file. Quitting";
    exit 0;
fi

# Extracting exact font name
filename_with_extension=$(basename $found)
filename_only="${filename_with_extension%.*}";

# Checking if font directory is created
fontdirexists=$(find $fontdirectorylocation -iname ".fonts");

if [ -z $fontdirexists ]
then
    echo "Font directory not found. Creating directory...";
    mkdir "$fontdirectorylocation/.fonts";
else
    # Check if font is already installed
    font_already_installed=$(find "$fontdirectorylocation/$fontdirectory" -iname $filename_only)

    if [ ! -z "$font_already_installed" ]
    then
        echo "Font is already installed. Quitting";
        exit 0;
    fi
fi

# Creating directory for the font files in current directory
folderexists=$(find $currentdir -type d -iname $filename_only);

if [ -z $folderexists ]
then
    mkdir $filename_only
fi

# Unzipping font files
cd $filename_only;
unzip $found;

# Moving outside the font files directory
cd ..;

# Moving the font files to font directory
mv $filename_only ~/.fonts;

# Resetting font cache
fc-cache -r -v
