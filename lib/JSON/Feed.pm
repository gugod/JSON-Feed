package JSON::Feed;
# ABSTRACT: An implementation of JSON Feed: https://jsonfeed.org/
use Moo;
use namespace::clean;

use Ref::Util qw< is_globref is_ioref is_scalarref >;
use Path::Tiny qw< path >;
use Try::Tiny;
use JSON;

use JSON::Feed::Types qw<JSONFeed>;

has version       => ( is => 'ro' );
has title         => ( is => 'ro' );
has description   => ( is => 'ro' );
has user_comment  => ( is => 'ro' );
has next_url      => ( is => 'ro' );
has icon          => ( is => 'ro' );
has favicon       => ( is => 'ro' );
has author        => ( is => 'ro' );
has home_page_url => ( is => 'ro' );
has feed_url      => ( is => 'ro' );
has expired_url   => ( is => 'ro' );
has hub           => ( is => 'ro' );
has items         => ( is => 'ro' );

sub parse {
    my ($class, $o) = @_;

    my $data;
    if (is_globref($o)) {
        local $/;
        my $content = <$o>;
        if (utf8::is_utf8($content)) {
            $data = from_json($content);
        } else {
            $data = decode_json($content);
        }

    } elsif (is_scalarref($o)) {
        $data = decode_json($$o);
    } elsif (-f $o) {
        $data = decode_json(path($o)->slurp);
    } else {
        die "Unable to tell the type of argument";
    }

    JSONFeed->assert_valid($data);

    return $class->new(%$data);
}

1;

=head1 SYNOPSIS

JSON::Feed->new

=head1 SYNOPSIS

Parsing:

    JSON::Feed->parse( '/path/feed.json' );
    JSON::Feed->parse( $file_handle );
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
