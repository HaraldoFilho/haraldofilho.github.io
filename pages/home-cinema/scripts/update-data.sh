#!/bin/bash

cd /home/pi/github/tinyhomecinema.github.io/scripts/html

wget 'https://letterboxd.com/hpfilho/list/my-film-collection/'
mv index.html films.html

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

wget 'https://letterboxd.com/hpfilho/tag/now-showing/diary/'
mv index.html diary.html

cd /home/pi/github/tinyhomecinema.github.io/scripts

./generate-data.pl

rm /home/pi/github/tinyhomecinema.github.io/scripts/html/*

git pull origin main
git add ../data/collection.js
git add ../data/films.js
git commit -m "[auto] Updated data"
git push origin main

cd /home/pi/github/haraldofilho.github.io/pages/home-cinema

cp -r /home/pi/github/tinyhomecinema.github.io/* .

git pull origin master
git add *
git commit -m "[auto] Updated home-cinema page"
git push origin master
