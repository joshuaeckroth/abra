#!/usr/bin/perl -w

use strict;

print "(defvar *cases*\n\n  (list\n\n";
while(<>) {
    if(m!^Goal: ([\w\-]+)\((.*\))!) {
        my $pred = $1;
        my $args = $2;
        print "   (make-exp-case\n     :groundtruth '(($pred";
        while($args =~ m!([^,\)]*)[,\)]!g) {
            my $arg = $1;
            print " \"".$arg."\"";
        }
        print "))\n     :evidence\n     '(";
    }
    if(m!^\t\(([\w\-]+)\((.*\))\)!) {
        my $pred = $1;
        my $args = $2;
        print "($pred";
        while($args =~ m!([^,\)]*)[,\)]!g) {
            my $arg = $1;
            if($arg eq '') { $arg = "_"; }
            print " \"".$arg."\"";
        }
        print ")\n      ";
    }
    if(m!^,!) {
        print "))\n\n";
    }
}
print "))))\n\n";
