#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use Test2::V0;

use JSON::Feed::Types qw(JSONFeedAuthor);

subtest JSONFeedAuthor => sub {
    my @good_vals = (
        { name => "Someone" },
        { name => "Someone", url => "https://example.com" },
        { url => "https://example.com" },
        { url => "https://example.com", "avatar" => "https://example.com/someone.jpg" },
    );
    
    for (@good_vals) {
        ok JSONFeedAuthor->check($_);
    }

    my @bad_vals = (
        {},
        { meh => "Bah" },
    );
    
    for (@bad_vals) {
        ok ! JSONFeedAuthor->check($_);
    }
};

done_testing;
