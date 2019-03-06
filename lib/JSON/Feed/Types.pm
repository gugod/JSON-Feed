package JSON::Feed::Types {
    use Type::Library -base;
    use Type::Utils -all;
    use Types::Standard qw<Str Bool Dict Optional ArrayRef>;

    my $Author = declare JSONFeedAuthor => as Dict[
        name => Optional[Str],
        url => Optional[Str],
        avatar => Optional[Str],
    ];

    my $Item = declare JSONFeedItem => as Dict[
        id => Str,
        url => Optional[Str],
        external_url => Optional[Str],
        title => Optional[Str],
        content_html => Optional[Str],
        content_text => Optional[Str],
        summary => Optional[Str],
        image => Optional[Str],
        banner_image => Optional[Str],
        date_published => Optional[Str],
        author => Optional[ $Author ],
        tags => Optional[ArrayRef[Str]],
    ];

    declare JSONFeed => as Dict[
        version => Str,
        title => Str,
        description => Optional[Str],
        user_comment => Optional[Str],
        next_url => Optional[Str],
        icon => Optional[Str],
        favicon => Optional[Str],
        author => Optional[ $Author ],
        home_page_url => Optional[Str],
        feed_url => Optional[Str],
        expired => Optional[Bool],
        hub => Optional[ArrayRef],
        items => ArrayRef[ $Item ],
    ];
    
    __PACKAGE__->meta->make_immutable;
};

1;
