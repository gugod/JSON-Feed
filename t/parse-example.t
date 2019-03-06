#!perl
use strict;
use warnings;
use Test2::V0;
use JSON qw<decode_json>;
use JSON::Feed::Types qw(JSONFeed);

my $json = json_example();

ok JSONFeed->assert_valid(decode_json($json));
done_testing;

sub json_example {
    return <<EXAMPLE;
{
    "version": "https://jsonfeed.org/version/1",
    "title": "My Example Feed",
    "home_page_url": "https://example.org/",
    "feed_url": "https://example.org/feed.json",
    "items": [
        {
            "id": "2",
            "content_text": "This is a second item.",
            "url": "https://example.org/second-item"
        },
        {
            "id": "1",
            "content_html": "<p>Hello, world!</p>",
            "url": "https://example.org/initial-post"
        }
    ]
}
EXAMPLE
}
