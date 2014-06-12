#!/usr/bin/perl -w

use strict;

print "(create-rules\n\n";
while(<>) {
    if(m!#!) {
        print $_."\n";
    }
    if(m! ;; ([\w\-]+)\((.*)\)\|!) {
        # new rule
        my $comment = $_;
        my $pred = $1;
        my $args = $2;
        print " (:antecedent\n\n";
        print " ".$comment."\n";
        print "  (($pred";
        while($args =~ m!([\w\-]+),?!g) {
            print " ?".lc($1);
        }
        print "))\n\n  :consequent\n  (\n";
    }
    if(m!\)[\.,]$!) {
        my $comment = $_;
        print "  ".$comment."\n";
        while(m!([\w\-]+)\((.*?)\)[,\.]!g) {
            my $pred = $1;
            my $args = $2;
            print "   ($pred";
            while($args =~ m!([\w\-]+),?!g) {
                print " ?".lc($1);
            }
            print ")\n\n";
        }
    }
    if(m!\.$!) {
        print "  ))\n\n";
    }
}
print ")\n";
