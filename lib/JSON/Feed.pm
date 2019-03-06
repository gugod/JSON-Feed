package JSON::Feed;
# ABSTRACT: An implementation of JSON Feed: https://jsonfeed.org/
use strict;
use warnings;


1;

=head1 SYNOPSIS

JSON::Feed->new

=head1 SYNOPSIS

Parsing:

    JSON::Feed->parse( '/path/feed.json' );
    JSON::Feed->parse( \$src );

Generating:

    my $feed = JSON::Feed->new(
        title    => "An example of JSON feed",
        feed_url => "https://example.com/feed.json",
        items    => [
            +{
                id => 42,
                url => 'https://example.com/item/42',
                summary => 'An item with some summary',
                date_published: "2019-03-06T09:24:03+09:00"
            },
            +{
                id => 623,
                url => 'https://example.com/item/623',
                summary => 'An item with some summary',
                date_published: "2019-03-07T06:22:51+09:00"
            },
        ]
    );

    # Output
    print $fh $feed->to_string;

=head1 References

JSON Feed spec v1 L<https://jsonfeed.org/version/1>
