#!/bin/bash

cd /home/pi/github/tinyhomecinema.github.io/

git pull origin main

cd /home/pi/github/tinyhomecinema.github.io/scripts/html

wget 'https://letterboxd.com/hpfilho/list/my-home-cinema-shelf/'
mv index.html shelf.html

wget 'https://letterboxd.com/hpfilho/list/my-film-collection/'
mv index.html films.html

wget 'https://letterboxd.com/hpfilho/list/my-short-films-collection/'
mv index.html shorts.html

wget 'https://letterboxd.com/hpfilho/list/my-special-feature-documentaries-collection/'
mv index.html documentaries.html

wget 'https://letterboxd.com/hpfilho/list/my-miniseries-collection/'
mv index.html miniseries.html

wget 'https://letterboxd.com/hpfilho/list/my-blu-ray-discs/'
mv index.html blu-ray.html

wget 'https://letterboxd.com/hpfilho/list/my-dvds/'
mv index.html dvd.html

wget 'https://letterboxd.com/hpfilho/list/blu-ray-dvd/'
mv index.html bd+dvd.html

wget 'https://letterboxd.com/hpfilho/list/my-dolby-atmos-discs/'
mv index.html atmos.html

wget 'https://letterboxd.com/hpfilho/list/my-dts-x-discs/'
mv index.html dtsx.html

wget 'https://letterboxd.com/hpfilho/rss/'
mv index.html rss.html

wget 'https://letterboxd.com/hpfilho/tag/first-showing/diary/'
mv index.html diary.html

cd /home/pi/github/tinyhomecinema.github.io/scripts

./generate-data.pl

rm /home/pi/github/tinyhomecinema.github.io/scripts/html/*

git add ../data/media.js
git add ../data/films.js
git commit -m "[auto] Updated data"
git push origin main

git diff HEAD^ HEAD ../data/media.js > media.diff
git diff HEAD^ HEAD ../data/films.js > films.diff

if [ -s media.diff ];
  then
    echo "The 'Physical Media' section of Cineminha web page has been updated." | mail -s "Cineminha web page update" "tinyhomecinema@gmail.com"
fi

if [ -s films.diff ];
  then
    echo "One or more films were added to 'LATEST RELEASES' section of Cineminha web page." | mail -s "Cineminha web page update" "tinyhomecinema@gmail.com"
fi

rm /home/pi/github/tinyhomecinema.github.io/scripts/*.diff

cd /home/pi/github/haraldofilho.github.io/pages/home-cinema

cp -r /home/pi/github/tinyhomecinema.github.io/* .

git pull origin master
git add *
git commit -m "[auto] Updated home-cinema page"
git push origin master
