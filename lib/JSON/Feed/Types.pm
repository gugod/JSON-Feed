package JSON::Feed::Types {
    use Type::Library -base;
    use Type::Utils -all;
    use Types::Standard qw<Str Int Bool Dict Optional ArrayRef>;
    use Types::Common::Numeric qw< PositiveOrZeroInt >;

    my $Author = declare JSONFeedAuthor => as Dict[
        name => Optional[Str],
        url => Optional[Str],
        avatar => Optional[Str],
    ];

    my $Attachment = declare JSONFeedAttachment => as Dict[
        url => Str,
        mime_type => Str,
        title => Optional[Str],
        size_in_bytes => Optional[PositiveOrZeroInt],
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
        attachments => Optional[ $Attachment ],
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
