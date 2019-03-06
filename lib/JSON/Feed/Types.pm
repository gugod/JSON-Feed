package JSON::Feed::Types {
    use Type::Library -base;
    use Type::Utils -all;
    use Types::Standard qw<Str Dict Optional ArrayRef>;

    declare JSONFeed => as Dict[
        version => Str,
        title => Str,
        home_page_url => Optional[Str],
        feed_url => Optional[Str],
        items => ArrayRef,
    ];

    __PACKAGE__->meta->make_immutable;
};

1;
