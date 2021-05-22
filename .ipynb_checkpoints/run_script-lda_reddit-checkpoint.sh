#!/usr/bin/env bash

echo "Creating environment"
VENVNAME=as5-venv 
python -m venv $VENVNAME

# This makes sure that the bash script can be run from bash emulator on windows 
# Test if the folder bin in venvname exists
if [ -d "$VENVNAME/bin" ]

    then
        source $VENVNAME/bin/activate
        echo "Building venv for Linux/Mac ..."
    
    else
        source $VENVNAME/Scripts/activate
        echo "Building venv for Windows ..."
fi

echo "Upgrading pip and installing dependencies"
#Upgrade pip
# I'm specifying that I'm using pip from python, since my pc have problems upgrading pip locally if I don't do it.
python -m pip install --upgrade pip

#Test requirements and install requirements
test -f requirements.txt && pip install -r requirements.txt

#Download en_core_web nlp
python -m spacy download en_core_web_sm

#Move to data folder
cd data

echo "Unzipping data"
#Unzip csv file (The file is to big to upload)
unzip r_wallstreetbets_posts.csv.zip

#Move to source folder
cd ../src

echo "Running script"
#Run python script
python lda-reddit.py $@

#Move to data folder
cd ../data

echo "Removing unzipped file"
#Remove unzipped csv file (this is done, so I can push the repo without hitting the limit for data storage)
rm -f r_wallstreetbets_posts.csv 

echo "Deactivating and removing environment"
#Deavtivate environment
deactivate

cd ..
rm -rf $VENVNAME

#Print this to the screen 
echo "Done! The results can be found in the folder 'output'"