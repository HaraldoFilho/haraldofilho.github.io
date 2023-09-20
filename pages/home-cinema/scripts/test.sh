#!/bin/bash

git diff HEAD^ HEAD ../data/films.js > films.diff
git diff HEAD^ HEAD ../data/media.js > media.diff

if [ -s films.diff ];
  then
    os.system("echo \"One or more films were added to Cineminha web page.\" | mail -s \"Cineminha web page data update\" tinyhomecinema@gmail.com")
fi

if [ -s media.diff ];
  then
    os.system("echo \"The Physical Media section of Cineminha web page has been updated.\" | mail -s \"Cineminha web page data update\" tinyhomecinema@gmail.com")
fi

rm *.diff

