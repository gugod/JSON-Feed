requires 'Path::Tiny';
requires 'Try::Tiny';
requires 'Type::Tiny';
requires 'JSON';
requires 'Moo';
requires 'FindBin';

on test => sub {
    requires 'Test2::V0';
};
