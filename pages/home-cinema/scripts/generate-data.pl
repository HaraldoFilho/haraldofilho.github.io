#!/usr/bin/perl

use strict;
use warnings;


# COLLECTION DATA

my $base_url = "https://letterboxd.com";

my $shelf = 'html/shelf.html';
open(SHELF, $shelf) or die("File $shelf not found");

my $films = 'html/films.html';
open(FILMS, $films) or die("File $films not found");

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

my $collection_data_file = '../data/collection.js';
open(COLLECTION_DATA, '>', $collection_data_file) or die("File $collection_data_file not found");

print COLLECTION_DATA "var collection = [\n";

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

print COLLECTION_DATA "  [\'Films / Miniseries\', $count, \'$url\', \'shelf\'],\n";

while (my $line = <FILMS>) {
    if ($line =~ /meta property=\"og\:url\" content=\"(.*)\"/) {
        $url = $1;
    }
    if ($line =~ /A list of ([0-9]*) films/) {
        $count = $1;
    }
}

print COLLECTION_DATA "  [\'Films\', $count, \'$url\', \'collection\'],\n";

while (my $line = <MINISERIES>) {
    if ($line =~ /meta property=\"og\:url\" content=\"(.*)\"/) {
        $url = $1;
    }
    if ($line =~ /A list of ([0-9]*) films/) {
       $count = $1;
    }
}

print COLLECTION_DATA "  [\'Miniseries\', $count, \'$url\', \'collection\'],\n";

while (my $line = <BLURAY>) {
    if ($line =~ /meta property=\"og\:url\" content=\"(.*)\"/) {
        $url = $1;
    }
    if ($line =~ /A list of ([0-9]*) films/) {
        $count = $1;
    }
}

print COLLECTION_DATA "  [\'Blu-ray\', $count, \'$url\', \'disc\'],\n";

while (my $line = <DVD>) {
    if ($line =~ /meta property=\"og\:url\" content=\"(.*)\"/) {
        $url = $1;
    }
    if ($line =~ /A list of ([0-9]*) films/) {
        $count = $1;
    }
}

print COLLECTION_DATA "  [\'DVD\', $count, \'$url\', \'disc\'],\n";

while (my $line = <BD_DVD>) {
    if ($line =~ /meta property=\"og\:url\" content=\"(.*)\"/) {
        $url = $1;
    }
    if ($line =~ /A list of ([0-9]*) films/) {
        $count = $1;
    }
}

print COLLECTION_DATA "  [\'BD\/DVD\', $count, \'$url\', \'disc\'],\n";

while (my $line = <ATMOS>) {
    if ($line =~ /meta property=\"og\:url\" content=\"(.*)\"/) {
        $url = $1;
    }
    if ($line =~ /A list of ([0-9]*) films/) {
        $count = $1;
    }
}

print COLLECTION_DATA "  [\'Dolby Atmos\', $count, \'$url\', \'audio\'],\n";

while (my $line = <DTSX>) {
    if ($line =~ /meta property=\"og\:url\" content=\"(.*)\"/) {
        $url = $1;
    }
    if ($line =~ /A list of ([0-9]*) films/) {
        $count = $1;
    }
}

print COLLECTION_DATA "  [\'DTS X\', $count, \'$url\', \'audio\'],\n";

print COLLECTION_DATA "]\n";

close(SHELF);
close(FILMS);
close(MINISERIES);
close(BLURAY);
close(DVD);
close(BD_DVD);
close(ATMOS);
close(DTSX);

close(COLLECTION_DATA);


# FILMS DATA

my $rss = 'html/rss.html';
open(RSS, $rss) or die("File $rss not found");

my $diary = 'html/diary.html';
open(DIARY, $diary) or die("File $diary not found");

my $films_data_file = '../data/films.js';
open(FILMS_DATA, '>', $films_data_file) or die("File $films_data_file not found");

print FILMS_DATA "var films = [\n";

my @film_ids;

while (my $line = <DIARY>) {
    if ($line =~ /data-viewing-id=\"(.*)\"\n/) {
        push @film_ids, $1;
    }
}

my $rating;
my $link;
my $id;
my $img;

while (my $line = <RSS>) {
    if ($line =~ /.*<title>.*\s-\s(.*)<\/title>\s<link>(.*)<\/link> <guid\s.*letterboxd-.*-(.*)<\/guid>.*<img src=\"(.*)\?v.*/) {
        $rating = $1;
        $link = $2;
        $id = $3;
        $img = $4;

        if ($rating =~ /(.*)\s\(.*/) {
            $rating = $1;
        }

        for (@film_ids) {
            if ($id == $_) {
                print FILMS_DATA "  [\'$link\', \'$img\', \'$rating\'],\n";
            }
        }
    }
}

print FILMS_DATA "]\n";

close(RSS);
close(DIARY);
close(FILMS_DATA);
