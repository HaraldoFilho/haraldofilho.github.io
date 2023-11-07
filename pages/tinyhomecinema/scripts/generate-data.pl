#!/usr/bin/perl

use strict;
use warnings;


# COLLECTION DATA

my $base_url = "https://letterboxd.com";

my $shelf = 'html/shelf.html';
open(SHELF, $shelf) or die("File $shelf not found");

my $tv_shows = 'html/tv_shows.html';
open(TV_SHOWS, $tv_shows) or die("File $tv_shows not found");

my $music = 'html/music.html';
open(MUSIC, $music) or die("File $music not found");

my $books = 'html/books.html';
open(BOOKS, $books) or die("File $books not found");

my $films = 'html/films.html';
open(FILMS, $films) or die("File $films not found");

my $shorts = 'html/shorts.html';
open(SHORTS, $shorts) or die("File $shorts not found");

my $documentaries = 'html/documentaries.html';
open(DOCS, $documentaries) or die("File $documentaries not found");

my $miniseries = 'html/miniseries.html';
open(MINISERIES, $miniseries) or die("File $miniseries not found");

my $bluray = 'html/blu-ray.html';
open(BLURAY, $bluray) or die("File $bluray not found");

my $dvd = 'html/dvd.html';
open(DVD, $dvd) or die("File $dvd not found");

my $bd_dvd = 'html/bd+dvd.html';
open(BD_DVD, $bd_dvd) or die("File $bd_dvd not found");

my $atmos = 'html/atmos.html';
open(ATMOS, $atmos) or die("File $atmos not found");

my $dtsx = 'html/dtsx.html';
open(DTSX, $dtsx) or die("File $dtsx not found");

my $media_data_file = '../data/media.js';
open(MEDIA_DATA, '>', $media_data_file) or die("File $media_data_file not found");


print MEDIA_DATA "var shelves = [\n";

my $url;
my $count;

while (my $line = <SHELF>) {
    if ($line =~ /meta property=\"og\:url\" content=\"(.*)\"/) {
        $url = $1;
    }
    if ($line =~ /A list of ([0-9]*) films/) {
        $count = $1;
    }
}

print MEDIA_DATA "  [\'Movies\', $count, \'$url\', \'shelf\'],\n";

while (my $line = <TV_SHOWS>) {
    if ($line =~ /meta property=\"og\:url\" content=\"(.*)\"/) {
        $url = $1;
    }
    if ($line =~ /<li><span><em>([0-9]*)<\/em><\/span><br>items on this list<\/li>/) {
        $count = $1;
    }
}

print MEDIA_DATA "  [\'TV Shows\', $count, \'$url\', \'shelf\'],\n";

$count = 0;

while (my $line = <MUSIC>) {
    if ($line =~ /cover_([0-9]*)\.jpg/) {
        $count += 1;
    }
}

print MEDIA_DATA "  [\'Music\', $count, \'https://tinyhomecinema.page/music/\', \'shelf\'],\n";

while (my $line = <BOOKS>) {
    if ($line =~ /<td class=\"pbGroup\">.*of\s([0-9]*)<\/td>/) {
        $count = $1;
    }
}

$url = 'https://www.librarything.com/catalog.php?view=hpfilho&collection=794026&shelf=shelf&sort=title&previousOffset=0&shelf_rows=3&collection=794026';

print MEDIA_DATA "  [\'Books\', $count, \'$url\', \'shelf\']\n";

print MEDIA_DATA "]\n";

print MEDIA_DATA "\nvar collection = [\n";

while (my $line = <FILMS>) {
    if ($line =~ /meta property=\"og\:url\" content=\"(.*)\"/) {
        $url = $1;
    }
    if ($line =~ /A list of ([0-9]*) films/) {
        $count = $1;
    }
}

print MEDIA_DATA "  [\'Films\', $count, \'$url\', \'collection\'],\n";

while (my $line = <SHORTS>) {
    if ($line =~ /meta property=\"og\:url\" content=\"(.*)\"/) {
        $url = $1;
    }
    if ($line =~ /A list of ([0-9]*) films/) {
        $count = $1;
    }
}

print MEDIA_DATA "  [\'Shorts\', $count, \'$url\', \'collection\'],\n";

while (my $line = <DOCS>) {
    if ($line =~ /meta property=\"og\:url\" content=\"(.*)\"/) {
        $url = $1;
    }
    if ($line =~ /A list of ([0-9]*) films/) {
        $count = $1;
    }
}

print MEDIA_DATA "  [\'Documentaries\', $count, \'$url\', \'collection\'],\n";

while (my $line = <MINISERIES>) {
    if ($line =~ /meta property=\"og\:url\" content=\"(.*)\"/) {
        $url = $1;
    }
    if ($line =~ /A list of ([0-9]*) films/) {
       $count = $1;
    }
}

print MEDIA_DATA "  [\'Miniseries\', $count, \'$url\', \'collection\'],\n";

while (my $line = <BLURAY>) {
    if ($line =~ /meta property=\"og\:url\" content=\"(.*)\"/) {
        $url = $1;
    }
    if ($line =~ /A list of ([0-9]*) films/) {
        $count = $1;
    }
}

print MEDIA_DATA "  [\'Blu-ray\', $count, \'$url\', \'disc\'],\n";

while (my $line = <DVD>) {
    if ($line =~ /meta property=\"og\:url\" content=\"(.*)\"/) {
        $url = $1;
    }
    if ($line =~ /A list of ([0-9]*) films/) {
        $count = $1;
    }
}

print MEDIA_DATA "  [\'DVD\', $count, \'$url\', \'disc\'],\n";

while (my $line = <BD_DVD>) {
    if ($line =~ /meta property=\"og\:url\" content=\"(.*)\"/) {
        $url = $1;
    }
    if ($line =~ /A list of ([0-9]*) films/) {
        $count = $1;
    }
}

print MEDIA_DATA "  [\'BD\/DVD\', $count, \'$url\', \'disc\'],\n";

while (my $line = <ATMOS>) {
    if ($line =~ /meta property=\"og\:url\" content=\"(.*)\"/) {
        $url = $1;
    }
    if ($line =~ /A list of ([0-9]*) films/) {
        $count = $1;
    }
}

print MEDIA_DATA "  [\'Dolby Atmos\', $count, \'$url\', \'audio\'],\n";

while (my $line = <DTSX>) {
    if ($line =~ /meta property=\"og\:url\" content=\"(.*)\"/) {
        $url = $1;
    }
    if ($line =~ /A list of ([0-9]*) films/) {
        $count = $1;
    }
}

print MEDIA_DATA "  [\'DTS X\', $count, \'$url\', \'audio\'],\n";

print MEDIA_DATA "]\n";

close(SHELF);
close(TV_SHOWS);
close(MUSIC);
close(BOOKS);
close(FILMS);
close(SHORTS);
close(DOCS);
close(MINISERIES);
close(BLURAY);
close(DVD);
close(BD_DVD);
close(ATMOS);
close(DTSX);

close(MEDIA_DATA);


# FILMS DATA

my $rss = 'html/rss.html';
open(RSS, $rss) or die("File $rss not found");

my $diary = 'html/diary.html';
open(DIARY, $diary) or die("File $diary not found");

my $films_data_file = '../data/films.js';
open(FILMS_DATA, $films_data_file) or die("File $films_data_file not found");

my $last_film_line = <FILMS_DATA>;
$last_film_line = <FILMS_DATA>;

close(FILMS_DATA);

open(FILMS_DATA, '>', $films_data_file) or die("File $films_data_file not found");

print FILMS_DATA "var films = [\n";

my @film_ids;

while (my $line = <DIARY>) {
    if ($line =~ /data-viewing-id=\"(.*)\"\n/) {
        push @film_ids, $1;
    }
}

my $title;
my $rating;
my $link;
my $id;
my $img;

my $new_film = 1;
my @new_films_titles;
my @new_films_links;
my @new_films_imgs;

while (my $line = <RSS>) {
    if ($line =~ /.*<title>(.*)\s-\s(.*)<\/title>\s<link>(.*)<\/link> <guid\s.*letterboxd-.*-(.*)<\/guid>.*<img src=\"(.*)\?v.*/) {
        $title = $1;
        $rating = $2;
        $link = $3;
        $id = $4;
        $img = $5;

        $title =~ s/&#039;/\\\'/;

        if ($rating =~ /(.*)\s\(.*/) {
            $rating = $2;
        }

        for (@film_ids) {
            if ($id == $_) {
                my $line_to_print = "  [\'$title\', \'$link\', \'$img\', \'$rating\'],\n";
                    print FILMS_DATA $line_to_print;
                if ($line_to_print ne $last_film_line && $new_film) {
                    $title =~ s/\\//;
                    push @new_films_titles, $title;
                    push @new_films_links, $link;
                    push @new_films_imgs, $img;
                } else {
                    $new_film = 0;
                }
            }
        }

    }
}

print FILMS_DATA "]\n";

close(RSS);
close(DIARY);
close(FILMS_DATA);


while (@new_films_titles) {
    $title = pop @new_films_titles;
    $link = pop @new_films_links;
    $img = pop @new_films_imgs;
    system("echo \"\<p style=\"font-size:16px\"\>The film \<a href=\"$link\"\>$title\<\/a\> has been added to \'LATEST RELEASES\'.\<\/p\>\<br\><img src=\"$img\" width=\"200\" \/\>\<br\>\<br\>\<br\>tinyhomecinema.page\<br\>\<br\>\" | mail -s \"Cineminha webpage update\" -a \"Content-type: text\/html\" -aFrom:\"Webpage Updater\<wozniak.iot\@gmail.com\>\" \"tinyhomecinema\@gmail.com\"");
}
