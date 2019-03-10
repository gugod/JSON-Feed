package JSON::Feed;

# ABSTRACT: An implementation of JSON Feed: https://jsonfeed.org/

use Moo;
use namespace::clean;

use Ref::Util qw< is_globref is_ioref is_scalarref >;
use Path::Tiny qw< path >;
use Try::Tiny;
use JSON;

use JSON::Feed::Types qw<JSONFeed JSONFeedItem>;

has feed => (
    is      => 'ro',
    default => sub {
        return +{
            version => "https://jsonfeed.org/version/1",
            title   => 'Untitle',
            items   => [],
        };
    },
    isa => JSONFeed,
);

around BUILDARGS => sub {
    my ( $orig, $class, %args ) = @_;

    if ( exists $args{feed} ) {
        return $class->$orig( feed => \%args );
    }

    return +{
        feed => +{
            version => "https://jsonfeed.org/version/1",
            title   => 'Unknown',
            items   => [],

            %args
        }
    };
};

sub parse {
    my ( $class, $o ) = @_;

    my $data;
    if ( is_globref($o) ) {
        local $/;
        my $content = <$o>;
        if ( utf8::is_utf8($content) ) {
            $data = from_json($content);
        }
        else {
            $data = decode_json($content);
        }

    }
    elsif ( is_scalarref($o) ) {
        $data = decode_json($$o);
    }
    elsif ( -f $o ) {
        $data = decode_json( path($o)->slurp );
    }
    else {
        die "Unable to tell the type of argument";
    }

    JSONFeed->assert_valid($data);

    return $class->new(%$data);
}

sub get {
    my ( $self, $attr_name ) = @_;
    return $self->feed->{$attr_name};
}

sub set {
    my ( $self, $attr_name, $v ) = @_;
    return $self->feed->{$attr_name} = $v;
}

sub add_item {
    my ( $self, %item ) = @_;
    my $item = \%item;
    JSONFeedItem->assert_valid($item);
    push @{ $self->feed->{items} }, $item;
}

sub to_string {
    my ($self) = @_;
    my $feed = $self->feed;
    if (exists $feed->{expired}) {
        $feed->{expired} = $feed->{expired} ? JSON::true : JSON::false;
    }
    return to_json( $feed );
}

1;

=head1 NAME

JSON::Feed - Syndication with JSON.

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
