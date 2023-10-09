#!/usr/bin/perl

use strict;
use warnings;


# COLLECTION DATA

my $base_url = "https://letterboxd.com";

my $shelf = 'html/shelf.html';
open(SHELF, $shelf) or die("File $shelf not found");

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
print MEDIA_DATA "  [\'TV Shows\', 6, \'https://www.themoviedb.org/list/8256420\', \'shelf\'],\n";
print MEDIA_DATA "  [\'Music\', 35, \'https://tinyhomecinema.page/music/\', \'shelf\'],\n";
print MEDIA_DATA "  [\'Books\', 26, \'https://www.librarything.com/catalog.php?view=hpfilho&collection=794026&shelf=shelf&sort=title&previousOffset=0&shelf_rows=3&collection=794026\', \'shelf\']\n";
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
my @new_films;

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
			push @new_films, $title;
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

while (@new_films) {
	$title = pop @new_films;
	system("echo \"The film \'$title\' has been added to \'LATEST RELEASES\'.\" | mail -s \"Cineminha web page update\" \"tinyhomecinema\@gmail.com\"");
}
