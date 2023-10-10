!/bin/bash

cd /home/pi/github/tinyhomecinema.github.io/

git pull origin main

cd /home/pi/github/tinyhomecinema.github.io/scripts/html

wget 'https://letterboxd.com/hpfilho/list/my-home-cinema-shelf/'
mv index.html shelf.html

wget 'https://www.themoviedb.org/list/8256420'
mv 8256420 tv_shows.html

wget 'https://www.librarything.com/catalog_bottom.php?view=hpfilho&collection=794026'
mv catalog_bottom.php?view\=hpfilho\&collection\=794026 books.html

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

cd /home/pi/github/haraldofilho.github.io/pages/home-cinema

cp -r /home/pi/github/tinyhomecinema.github.io/* .

git pull origin master
git add *
git commit -m "[auto] Updated home-cinema page"
git push origin master
